	.code16
	.global _start
_start:
	mov $hello, %si
	call print_string

	jmp .

print:
	mov $0x0e, %ah
	int $0x10
	ret

print_string:
	lodsb
	or %al, %al
	jz return
	call print
	jmp print_string

return:
	ret

hello:
	.asciz "hello"

	.space 510 - (. - _start)
	.short 0xaa55
