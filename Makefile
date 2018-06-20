BUILD_DIR ?= $(CURDIR)/build

ifdef ZERORISCY_PULP
ARCH_FLAGS?=ZERORISCY_PULP
else
ifdef ZERORISCY
ARCH_FLAGS?=ZERORISCY
else
ifdef MICRORISCY
ARCH_FLAGS?=MICRORISCY
else
ifdef RISCY_FPU
ARCH_FLAGS?=RISCY_FPU
else
ARCH_FLAGS?=
endif
endif
endif
endif


.PHONY: build

build:  
	if [ ! -e ri5cy_gnu_toolchain ]; then git clone https://github.com/pulp-platform/ri5cy_gnu_toolchain; fi
	tar mcvfz lisc_tools_delta.tar.gz ./binutils && cp lisc_tools_delta.tar.gz ri5cy_gnu_toolchain
	cp Makfile.lisc ./riscy_gnu_toolchain/Makefile
	cd ./ri5cy_gnu_toolchain && make $(ARCH_FLAGS)
