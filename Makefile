boot.bin: boot.o
	ld \
		-Ttext=0x7c00 \
		--oformat binary \
		-m elf_i386 \
		-o boot.bin \
		boot.o

boot.o: boot.s
	as \
		--32 \
		-o boot.o \
		boot.s

	objcopy \
		--remove-section=.note.gnu.property \
		boot.o boot.o

clean:
	rm boot.o boot.bin
