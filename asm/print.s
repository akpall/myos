	.code16 ; Real mode code
print:
	mov $0x0e, %ah
	int $0x10
	ret

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

print_string:
	lodsb
	or %al, %al
	jz print_string_null
	call print
	jmp print_string

print_string_null:
	ret

	.code32			; Protected mode code
	.set VIDEO_MEMORY, 0xb8000
	.set WHITE_ON_BLACK, 0x0f

print_string_pm:
	pusha
	mov $VIDEO_MEMORY, %edx

print_string_pm_loop:
	mov (%ebx), %al
	mov $WHITE_ON_BLACK, %ah

	cmp $0, %al
	je print_string_pm_done

	mov %ax, (%edx)

	add $1, %ebx
	add $2, %edx

	jmp print_string_pm_loop

print_string_pm_done:
	popa
	ret
