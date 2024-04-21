	.code16
HEX_CODES:
	.ascii "0123456789abcdef"

HEX_START:
	.asciz "0x"

print:
	mov $0x0e, %ah
	int $0x10
	ret

print_hex:
	mov $HEX_START, %si
	call print_string
	;;
	mov %dx, %ax
	and $0xf000, %ax
	shr $12, %ax
	add $HEX_CODES, %ax
	mov %ax, %si
	mov (%si),%ax
	call print
	;;
	mov %dx, %ax
	and $0xf00, %ax
	shr $8, %ax
	add $HEX_CODES, %ax
	mov %ax, %si
	mov (%si),%ax
	call print
	;;
	mov %dx, %ax
	and $0xf0, %ax
	shr $4, %ax
	add $HEX_CODES, %ax
	mov %ax, %si
	mov (%si),%ax
	call print
	;;
	mov %dx, %ax
	and $0xf, %ax
	add $HEX_CODES, %ax
	mov %ax, %si
	mov (%si),%ax
	call print
	;;
	mov $' ', %al
	call print
	;;
	ret

print_string:
	lodsb
	or %al, %al
	jz print_string_null
	call print
	jmp print_string

print_string_null:
	ret
