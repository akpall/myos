gdt_start:
	# Null descriptor
	.long 0x0
	.long 0x0

gdt_code:
	.short 0xffff
	.short 0x0
	.byte 0x0
	.byte 0x9a
	.byte 0xcf
	.byte 0x0

gdt_data:
	.short 0xffff
	.short 0x0
	.byte 0x0
	.byte 0x92
	.byte 0x8f
	.byte 0x0

gdt_end:

gdt_descriptor:
	.short gdt_end - gdt_start - 1
	.long gdt_start
