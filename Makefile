boot.bin: boot.o
	objcopy \
		--remove-section=.note.gnu.property \
		-O binary \
		boot.o boot.bin

boot.o: boot.s
	as \
		--32 \
		-o boot.o \
		boot.s
