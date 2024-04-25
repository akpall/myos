myos.bin: build/boot.bin build/kernel.bin
	cat build/boot.bin build/kernel.bin > myos.bin

build/boot.bin: build/boot.o
	ld \
		-Ttext=0x7c00 \
		--oformat binary \
		-m elf_i386 \
		-o build/boot.bin \
		build/boot.o

build/kernel.bin: build/kernel.o
	ld \
		-Ttext=0x1000 \
		--oformat binary \
		-m elf_i386 \
		-e kernel_main \
		-o build/kernel.bin \
		build/kernel.o

build/boot.o: asm/boot.s
	cc \
		-m32 \
		-c \
		-fno-pie \
		-o build/boot.o \
		asm/boot.s
	objcopy \
	 	--remove-section=.note.gnu.property \
	 	build/boot.o build/boot.o

build/kernel.o: c/kernel.c
	cc \
		-m32 \
		-ffreestanding \
		-fno-pie \
		-c \
		-o build/kernel.o \
		c/kernel.c
	objcopy \
		--remove-section=.note.gnu.property \
		--remove-section=.eh_frame \
		--remove-section=.comment \
		build/kernel.o build/kernel.o

clean:
	rm build/boot.o build/boot.bin build/kernel.bin build/kernel.o myos.bin
