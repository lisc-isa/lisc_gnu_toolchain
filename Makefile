ifdef ZERORISCY_PULP
MAKE_FLAGS?=ZERORISCY_PULP
else
ifdef ZERORISCY
MAKE_FLAGS?=ZERORISCY
else
ifdef MICRORISCY
MAKE_FLAGS?=MICRORISCY
else
ifdef RISCY_FPU
MAKE_FLAGS?=RISCY_FPU
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
