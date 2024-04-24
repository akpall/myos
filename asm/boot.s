	.code16
	.global _start
_start:
	# Save boot device into BOOT_DRIVE var
	mov %dl, BOOT_DRIVE

	# Set stack and stack base pointers
	mov $0x8000, %bp
	mov %bp, %sp

	# Load 2 sectors from BOOT_DRIVE into 0x9000
	mov $0x9000, %bx
	mov $2, %dh
	mov BOOT_DRIVE, %dl
	call disk_load

	# Print hex at 0x9000
	mov $0x9000, %si
	mov (%si), %dx
	call print_hex

	# Print hex at 0x9000+512
	mov $0x9000+512, %si
	mov (%si), %dx
	call print_hex

	jmp .

# Include asm code from files here
	.include "asm/print.s"
	.include "asm/disk.s"

# Vars
BOOT_DRIVE:
	.byte 0

DISK_ERROR_MSG:
	.asciz "Disk read error!"

HEX_CODES:
	.ascii "0123456789abcdef"

HEX_START:
	.asciz "0x"

# Pad until 510 and enter boot sector magic number
	.space 510 - (. - _start)
	.short 0xaa55

# Filling, to test disk reading
	.fill 256, 2, 0xdada
	.fill 256, 2, 0xface
