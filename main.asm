section .text
    global _start

extern kmain

_start:
    call kmain
    hlt
