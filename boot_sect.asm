[BITS 16]
[ORG 0x7C00]

start:
    mov ah, 0x0E
    mov al, 'H'
    int 0x10
    mov al, 'e'
    int 0x10
    mov al, 'l'
    int 0x10
    mov al, 'l'
    int 0x10
    mov al, 'o'
    int 0x10

    cli
    hlt

times 510-($-$$) db 0
dw 0xAA55
