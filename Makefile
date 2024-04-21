asm/boot.bin: asm/boot.o
	ld \
		-Ttext=0x7c00 \
		--oformat binary \
		-m elf_i386 \
		-o boot.bin \
		asm/boot.o

asm/boot.o: asm/boot.s
	as \
		--32 \
		-o asm/boot.o \
		asm/boot.s

	objcopy \
		--remove-section=.note.gnu.property \
		asm/boot.o asm/boot.o

clean:
	rm asm/boot.o boot.bin
