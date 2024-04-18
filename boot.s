	.code16
	.global _start
_start:
	mov $0x1fb6, %dx
	call print_hex

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

print_hex:
	mov $hex_start, %si
	call print_string

	mov %dx, %ax
	and $0xf000, %ax
	shr $12, %ax
	add $hex_codes, %ax
	mov %ax, %si
	mov (%si),%ax
	call print

	mov %dx, %ax
	and $0xf00, %ax
	shr $8, %ax
	add $hex_codes, %ax
	mov %ax, %si
	mov (%si),%ax
	call print

	mov %dx, %ax
	and $0xf0, %ax
	shr $4, %ax
	add $hex_codes, %ax
	mov %ax, %si
	mov (%si),%ax
	call print

	mov %dx, %ax
	and $0xf, %ax
	add $hex_codes, %ax
	mov %ax, %si
	mov (%si),%ax
	call print

return:
	ret

hex_start:
	.asciz "0x"

hex_codes:
	.ascii "0123456789abcdef"

	.space 510 - (. - _start)
	.short 0xaa55
