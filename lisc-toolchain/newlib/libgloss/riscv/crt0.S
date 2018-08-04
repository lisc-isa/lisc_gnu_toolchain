#=========================================================================
# crt0.S : Entry point for RISC-V user programs
#=========================================================================

.weak _board_mem_base
.weak _board_mem_size

__mem_base:        .long   0x0
# __mem_size:        .long   0x1000000
__mem_size:        .long   0x30000

	.section .data
	/* One single int for program argc */
	.global argc
argc:	.space  4,0
	.global argv
	/* Up to 20 arguments value can be passe to the program */
argv:	.space  4*20, 0
	.global argbuf
	/* 2 Kb of buffer usable by argv */
argbuf:	.space  2048, 0
	.global stack
stack:	.space  4,0     

  .text
  .global _start
_start:
  # Initialize global pointer
1:auipc gp, %pcrel_hi(_gp)
  addi  gp, gp, %pcrel_lo(1b)

# clear the bss segment
  la      t0, _fbss
  la      t1, _end
1:
#ifdef __riscv64
  sd      zero,0(t0)
  addi    t0, t0, 8
#else
  sw      zero,0(t0)
  addi    t0, t0, 4
#endif
  bltu    t0, t1, 1b

# Set sp to top of memory, stack grows downward
  la      t0, __mem_base
  la      t1, __mem_size
  lw      t0, 0(t0)
  lw      t1, 0(t1)
  add	  sp, t0, t1
# Store stack top in stack variable
  la      t0, stack
  sw      sp, 0(t0)

#  la      a0, __libc_fini_array   # Register global termination functions
#  call    atexit                  #  to be called upon exit
# 对于riscv-pk这类的程序，不太需要做相关的初始化处理，因为是有虚实地址的，不需要把整个memory空间都初始化的 
#  call    __libc_init_array       # Run global initialization functions

#  la      a0, argc
#  lw      a0, 0(a0)
#  la      a1, argv
#  li      a2, 0
#ifdef OLD
#  lw      a0, 0(sp)               # a0 = argc
#  addi    a1, sp, _RISCV_SZPTR/8  # a1 = argv
#  li      a2, 0                   # a2 = envp = NULL
#endif
  call    main
  tail    exit

  .global _init
  .global _fini
_init:
_fini:
  # These don't have to do anything since we use init_array/fini_array.
  ret
