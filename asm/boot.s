	.code16
	.global _start
_start:
	# Save boot device into BOOT_DRIVE var
	mov %dl, BOOT_DRIVE

	# Set stack and stack base pointers
	mov $0x8000, %bp
	mov %bp, %sp

	mov $MSG_REAL_MODE, %si
	call print_string

	call switch_to_pm

	jmp .

	.code32
begin_pm:
	mov $MSG_PROT_MODE, %ebx
	call print_string_pm

	jmp .

# Include asm code from files here
	.include "asm/print.s"
	.include "asm/disk.s"
	.include "asm/gdt.s"
	.include "asm/pm.s"

# Vars
	.set CODE_SEG, gdt_code - gdt_start
	.set DATA_SEG, gdt_data - gdt_start

BOOT_DRIVE:
	.byte 0

DISK_ERROR_MSG:
	.asciz "Disk read error!"

HEX_CODES:
	.ascii "0123456789abcdef"

HEX_START:
	.asciz "0x"

MSG_PROT_MODE:
	.asciz "Starting in 32-bit mode!"

MSG_REAL_MODE:
	.asciz "Starting in 16-bit mode!"

MSG_LOAD_KERNEL:
	.asciz "Loading kernel..."

# Pad until 510 and enter boot sector magic number
	.space 510 - (. - _start)
	.short 0xaa55
