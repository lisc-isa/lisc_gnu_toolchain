ifdef ZEROLISC_PULP
MAKE_FLAGS?= ZEROLISC_PULP=1
else
ifdef ZEROLISC
MAKE_FLAGS?= ZEROLISC=1
else
ifdef MICROLISC
MAKE_FLAGS?= MICROLISC=1
else
ifdef LISC_FPU
MAKE_FLAGS?= LISC_FPU=1
else
MAKE_FLAGS?=
endif
endif
endif
endif


.PHONY: build

build:
	if [ ! -e ri5cy_gnu_toolchain ]; then git clone https://github.com/pulp-platform/ri5cy_gnu_toolchain; fi
	cd lisc-toolchain && tar mcvfz lisc_tools_delta.tar.gz * && cp lisc_tools_delta.tar.gz $(CURDIR)/ri5cy_gnu_toolchain
	cd origin-toolchain && tar mcvfz lisc_origin-toolchain_delta.tar.gz * && cp lisc_origin-toolchain_delta.tar.gz $(CURDIR)/ri5cy_gnu_toolchain
	cp Makefile.lisc $(CURDIR)/ri5cy_gnu_toolchain/Makefile
	cd $(CURDIR)/ri5cy_gnu_toolchain && make $(MAKE_FLAGS)
	
install:
	cp -rf ./ri5cy_gnu_toolchain/install .
	cd ./install/bin; \
	FILES=$$(ls); \
	for var in $$FILES; do \
		mv -f $$var `echo "$$var" | sed 's/^..../lisc/'`; done

clean:
	rm -rf ./install
