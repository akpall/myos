CC = gcc
LD = ld

CFLAGS = \
	-Wall \
	-Wextra \
	-c \
	-ffreestanding \
	-fno-pie \
	-m32

LDFLAGS = \
	--oformat binary \
	-m elf_i386

CSRC = $(wildcard kernel/*.c)
COBJ = ${subst .c,.o,${CSRC}}

myos.bin: build/boot.bin build/kernel.bin
	cat build/boot.bin build/kernel.bin > myos.bin

build/boot.bin: build/boot.o
	objcopy \
	 	--remove-section=.note.gnu.property \
	 	build/boot.o build/boot.o
	$(LD) \
		$(LDFLAGS) \
		-Ttext=0x7c00 \
		-o build/boot.bin \
		build/boot.o

build/kernel.bin: build/kernel.o
	objcopy \
		--remove-section=.note.gnu.property \
		--remove-section=.eh_frame \
		--remove-section=.comment \
		build/kernel.o build/kernel.o
	$(LD) \
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

clean:
	rm -f build/* myos.bin

build/%.o: kernel/%.c
	$(CC) $(CFLAGS) -o $@ $<
