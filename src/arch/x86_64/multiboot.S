/*
#section .multiboot_header
header_start:
    dd 0xe85250d6                   ; magic number (multiboot 2)
    dd 0                            ; architecture 0 (protected mode i386)
    dd header_end - header_start    ; header length
    ; checksum
    dd 0x100000000 - (0xe85250d6 + 0 + (header_end - header_start))

    ; insert optional multiboot tags here

    ; required end tag
    dw 0 ; type
    dw 0 ; flags
    dd 8 ; size
header_end:
*/

.set MAGIC, 0xe85250d6 // Magic number 
.set ARCH,  0 // arch 0 => i386 protected mode

.section .multiboot
.align 4
header_start:
    .int MAGIC
    .int ARCH
    
    // header length
    .int (header_end - header_start) 
    // checksum
    .int -(MAGIC + ARCH + (header_end - header_start))

    // optional multiboot tags

    // required end tag
    .short 0 // tag
    .short 0 // flags
    .int 8   // size
header_end:

