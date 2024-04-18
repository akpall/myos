	.code16
_start:
	mov $'H', %al
	call print

	mov $'e', %al
	call print

	mov $'l', %al
	call print

	mov $'l', %al
	call print

	mov $'o', %al
	call print

	jmp .

print:
	mov $0x0e, %ah
	int $0x10
	ret

	.space 510 - (. - _start)
	.short 0xaa55
