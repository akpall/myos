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

	call load_kernel

	call switch_to_pm

	jmp .

load_kernel:
	mov $MSG_LOAD_KERNEL, %si
	call print_string

	mov $KERNEL_OFFSET, %bx
	mov $1, %dh
	mov BOOT_DRIVE, %dl
	call disk_load

	ret

	.code32
begin_pm:
	mov $MSG_PROT_MODE, %ebx
	call print_string_pm

	mov $KERNEL_OFFSET, %ax
	call %ax

	jmp .

# Include asm code from files here
	.include "boot/print.s"
	.include "boot/disk.s"
	.include "boot/gdt.s"
	.include "boot/pm.s"

# Vars
	.set CODE_SEG, gdt_code - gdt_start
	.set DATA_SEG, gdt_data - gdt_start
	.set KERNEL_OFFSET, 0x1000

BOOT_DRIVE:
	.byte 0

DISK_ERROR_MSG:
	.asciz "Disk read error!\r\n"

HEX_CODES:
	.ascii "0123456789abcdef"

HEX_START:
	.asciz "0x"

MSG_PROT_MODE:
	.asciz "Starting in 32-bit mode!\r\n"

MSG_REAL_MODE:
	.asciz "Starting in 16-bit mode!\r\n"

MSG_LOAD_KERNEL:
	.asciz "Loading kernel...\r\n"

# Pad until 510 and enter boot sector magic number
	.space 510 - (. - _start)
	.short 0xaa55
