ENTRY(_start)

SECTIONS
{
    . = 1M;

    .boot :
    {
        /* ensure that the multiboot header is at the beginning */
        *(.multiboot)
    }

    .text : /*BLOCK(4K) : ALIGN(4K)*/
    {
        *(.text)
    }
}

