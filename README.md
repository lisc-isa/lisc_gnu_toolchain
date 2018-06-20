# lisc_gnu_toolchain
LISC指令系统是在RISC-V指令系统基础上开发的全新指令系统，具有以下特点：
  1. 16个系统寄存器；
  2. 全新的指令编码；
  3. 大多数指令包含3-4比特的CLIPS位（Cross-Layer Information Parcels），在指令系统中不定义，用于未来定制指令系统之用；
  4. 去除‘JAL’指令的Rd位域，由INSN[28]=1定义PC+4回写，回写地址固定为x1 （去除RISC-V中回写x5的abi）；INSN[28]=0时，不回写，汇编助记符为'J'；
  5. ‘JALR’指令，由INSN[28]=1定义PC+4回写到Rd寄存器；INSN[28]=0时，不回写，汇编助记符为'Jr'；
  6. LISC指令系统的16位指令完全采用RV32E指令编码。

LISC指令系统用于北京大学信息科学技术学院《数字逻辑和微处理器设计》课程的教学之用，也向外界全面开放。参见LICENSE文件。

lisc_gnu_toolchian采用https://github.com/pulp-platform/ri5cy_gnu_toolchain 工具链。更改了其中binutils的若干文件而成。
