.section ".text.boot"

.global _start

_start:
    // setup stack
    mov sp, #0x8000
    
    // clear out bss.
    ldr r4, = __bss_start
    ldr r9, = __bss_end
    mov r5, #0
    mov r6, #0
    mov r7, #0
    mov r8, #0
    b       2f

// store multiple at r4
1:
    stmia r4!, {r5-r8}

//if we are still below bss_end, loop.
2:
    cmp r4, r9
    blo 1b

    // call kernel_main
    ldr r3, =kernel_main
    blx r3

// halt
halt:
    wfe
    b halt

