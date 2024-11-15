all: os-image

os-image: boot_sect.bin kernel.bin
	cat $^ > os-image

boot_sect.bin: boot_sect.asm
	nasm -f bin -o $@ $<

kernel.bin: main.o kernel_entry.o
	ld -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

main.o: main.c
	gcc -m32 -ffreestanding -fno-pic -fno-builtin -nostdlib -c $< -o $@

kernel_entry.o: kernel_entry.asm
	nasm -f elf32 -o $@ $<

clean:
	rm -f *.bin *.o os-image
