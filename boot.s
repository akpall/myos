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
	mov $HEX_START, %si
	call print_string

	mov %dx, %ax
	and $0xf000, %ax
	shr $12, %ax
	add $HEX_CODES, %ax
	mov %ax, %si
	mov (%si),%ax
	call print

	mov %dx, %ax
	and $0xf00, %ax
	shr $8, %ax
	add $HEX_CODES, %ax
	mov %ax, %si
	mov (%si),%ax
	call print

	mov %dx, %ax
	and $0xf0, %ax
	shr $4, %ax
	add $HEX_CODES, %ax
	mov %ax, %si
	mov (%si),%ax
	call print

	mov %dx, %ax
	and $0xf, %ax
	add $HEX_CODES, %ax
	mov %ax, %si
	mov (%si),%ax
	call print

	mov $' ', %al
	call print
	ret

disk_load:
	push %dx

	mov $0x02, %ah
	mov %dh, %al
	mov $0, %ch
	mov $0x02, %cl
	mov $0, %dh
	int $0x13

	jc disk_error

	pop %dx
	cmp %al, %dh
	jne disk_error
	ret

disk_error:
	mov $DISK_ERROR_MSG, %si
	call print_string
	jmp .

return:
	ret

HEX_START:
	.asciz "0x"

HEX_CODES:
	.ascii "0123456789abcdef"

DISK_ERROR_MSG:
	.asciz "Disk read error!"

	.space 510 - (. - _start)
	.short 0xaa55
