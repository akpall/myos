	.code16
disk_error:
	mov $DISK_ERROR_MSG, %si
	call print_string
	jmp .

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
