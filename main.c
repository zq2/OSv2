#include <stddef.h>
#include <stdint.h>

// VGA text mode buffer
volatile uint16_t* vga_buffer = (uint16_t*)0xB8000;
const int VGA_WIDTH = 80;
const int VGA_HEIGHT = 25;
int vga_index = 0;

void clear_screen() {
    for (int i = 0; i < VGA_WIDTH * VGA_HEIGHT; i++) {
        vga_buffer[i] = (uint16_t) ' ' | (0x0F << 8); // White text on black background
    }
    vga_index = 0;
}

void print_char(char c) {
    vga_buffer[vga_index++] = (uint16_t) c | (0x0F << 8); // White text on black background
}

void print(const char* str) {
    for (size_t i = 0; str[i] != '\0'; i++) {
        print_char(str[i]);
    }
}

void kmain(void) {
    clear_screen();
    print("Kernel started successfully!\n");
    while (1) { }
}