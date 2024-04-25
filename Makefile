CC = gcc
CFLAGS = -Wall -Wextra -c -ffreestanding -fno-pie -m32
LDFLAGS = --oformat binary -m elf_i386

myos.bin: build/boot.bin build/kernel.bin
	cat build/boot.bin build/kernel.bin > myos.bin

build/boot.bin: build/boot.o
	ld \
		$(LDFLAGS) \
		-Ttext=0x7c00 \
		-o build/boot.bin \
		build/boot.o

build/kernel.bin: build/kernel.o
	ld \
		$(LDFLAGS) \
		-Ttext=0x1000 \
		-e kernel_main \
		-o build/kernel.bin \
		build/kernel.o

build/boot.o: boot/boot.s
	$(CC) \
		$(CFLAGS) \
		-o build/boot.o \
		boot/boot.s
	objcopy \
	 	--remove-section=.note.gnu.property \
	 	build/boot.o build/boot.o

build/kernel.o: kernel/kernel.c
	$(CC) \
		$(CFLAGS) \
		-o build/kernel.o \
		kernel/kernel.c
	objcopy \
		--remove-section=.note.gnu.property \
		--remove-section=.eh_frame \
		--remove-section=.comment \
		build/kernel.o build/kernel.o

clean:
	rm build/boot.o build/boot.bin build/kernel.bin build/kernel.o myos.bin
