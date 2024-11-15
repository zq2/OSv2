section .text
global _start
extern kmain

_start:
    cli                 ; Disable interrupts
    mov ax, 0x10        ; Kernel data segment selector
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ax, 0x10        ; Kernel stack segment
    mov ss, ax
    mov sp, 0x7C00      ; Set stack pointer

    sti                 ; Enable interrupts
    call kmain          ; Call the kernel main function
    hlt                 ; Halt the CPU
    jmp $
