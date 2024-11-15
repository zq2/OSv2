void kmain(void) {
    const char *str = "Hello";
    while (*str) {
        __asm__ __volatile__ (
            "movb $0x0E, %%ah\n"
            "movb %0, %%al\n"
            "int $0x10\n"
            :
            : "r"(*str)
        );
        str++;
    }
    while (1) { }
}
