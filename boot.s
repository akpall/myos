.code16
_start:
	mov $0x0e, %ah
	mov $'H', %al
	int $0x10

	mov $0x0e, %ah
	mov $'e', %al
	int $0x10

	mov $0x0e, %ah
	mov $'l', %al
	int $0x10

	mov $0x0e, %ah
	mov $'l', %al
	int $0x10

	mov $0x0e, %ah
	mov $'o', %al
	int $0x10

	jmp .

	.space 510 - (. - _start)
	.short 0xaa55
