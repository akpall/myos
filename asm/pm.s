	.code16
switch_to_pm:
	cli

	lgdt gdt_descriptor

	mov %cr0, %eax
	or $0x1, %eax
	mov %eax, %cr0

	ljmp $CODE_SEG, $init_pm

	.code32
init_pm:
	mov $DATA_SEG, %ax
	mov %ax, %ds
	mov %ax, %ss
	mov %ax, %es
	mov %ax, %fs
	mov %ax, %gs

	mov $0x90000, %ebp
	mov %ebp, %esp

	call begin_pm
