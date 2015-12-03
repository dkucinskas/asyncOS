#section .multiboot_header
#header_start:
#    dd 0xe85250d6                   ; magic number (multiboot 2)
#    dd 0                            ; architecture 0 (protected mode i386)
#    dd header_end - header_start    ; header length
#    ; checksum
#    dd 0x100000000 - (0xe85250d6 + 0 + (header_end - header_start))
#
#    ; insert optional multiboot tags here
#
#    ; required end tag
#    dw 0 ; type
#    dw 0 ; flags
#    dd 8 ; size
#header_end:

.set ALIGN,   1<<0
.set MEMINFO, 1<<1
.set FLAGS,   ALIGN | MEMINFO
.set MAGIC,   0x1BADB002
.set CHECKSUM, -(MAGIC + FLAGS) 

.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

