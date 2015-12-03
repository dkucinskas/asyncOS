/*global start

section .text
bits 32
start:
    ; print `OK` to screen
    mov dword [0xb8000], 0x2f4b2f4f
    hlt
*/
.section .text
.global _start

_start:
    // print `OK` to screen
    movl $0x2f4b2f4f, 0xb8000 

    cli
    hlt

