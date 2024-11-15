BITS 16
org 0x7c00

start:
    ; Set up the stack
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00
    sti

    ; Print hello message
    mov si, hello_msg
    call print_string

    ; Load the kernel
    mov ax, 0x1000      ; Segment where the kernel is loaded (1MB)
    mov es, ax
    call load_kernel

    ; Print kernel loaded message
    mov si, kernel_loaded_msg
    call print_string

    ; Jump to the kernel
    jmp 0x1000:0x0000

disk_error:
    ; Print disk error message
    mov si, disk_error_msg
    call print_string
    hlt

load_kernel:
    mov ah, 0x02    ; BIOS read sector function
    mov al, 0x01    ; Number of sectors to read
    mov ch, 0x00    ; Cylinder number
    mov cl, 0x02    ; Sector number (start from sector 2)
    mov dh, 0x00    ; Head number
    mov dl, 0x80    ; Drive number (first hard disk)
    int 0x13
    jc disk_error   ; Jump to disk_error if carry flag is set
    ret

print_string:
    mov ah, 0x0E    ; BIOS teletype function
.print_char:
    lodsb           ; Load byte at DS:SI into AL
    cmp al, 0
    je .done
    int 0x10        ; Print character in AL
    jmp .print_char
.done:
    ret

hello_msg db 'Hello, booting kernel...', 0
kernel_loaded_msg db 'Kernel loaded, jumping...', 0
disk_error_msg db 'Disk read error', 0

times 510-($-$$) db 0
dw 0xAA55