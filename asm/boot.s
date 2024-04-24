	.code16
	.global _start
_start:
	mov %dl, BOOT_DRIVE

	mov $0x8000, %bp
	mov %bp, %sp

	mov $0x9000, %bx
	mov $2, %dh
	mov BOOT_DRIVE, %dl
	call disk_load

	mov $0x9000, %si
	mov (%si), %dx
	call print_hex

	mov $0x9000+512, %si
	mov (%si), %dx
	call print_hex

	jmp .

	.include "asm/print.s"
	.include "asm/disk.s"

BOOT_DRIVE:
	.byte 0

DISK_ERROR_MSG:
	.asciz "Disk read error!"

	.space 510 - (. - _start)
	.short 0xaa55

	.fill 256, 2, 0xdada
	.fill 256, 2, 0xface
