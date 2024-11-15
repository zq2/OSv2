section .text
    global _start

_start:
    cli
    cld
    call _start
    hlt
