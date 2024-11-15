all: os-image

os-image: boot_sect.bin kernel.bin
	cat $^ > os-image

boot_sect.bin: boot_sect.asm
	nasm -f bin -o $@ $<

kernel.bin: kernel_entry.o main.o
	ld -m elf_i386 -o kernel.elf -Ttext 0x1000 $^
	objcopy -O binary kernel.elf kernel.bin

main.o: main.c
	gcc -m32 -ffreestanding -c -o $@ $<

kernel_entry.o: kernel_entry.asm
	nasm -f elf32 -o $@ $<

clean:
	rm -f *.bin *.o *.elf os-image