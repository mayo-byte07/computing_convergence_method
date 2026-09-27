	.arch armv8-a
	.file	"5_general_optimizations.c"
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"ccm log2(%d) = %d\n"
	.section	.text.startup,"ax",@progbits
	.align	2
	.p2align 4,,15
	.global	main
	.type	main, %function
main:
.LFB4361:
	.cfi_startproc
	adrp	x0, .LC0
	mov	w2, -24148
	str	x30, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 30, -16
	mov	w1, 19660
	add	x0, x0, :lo12:.LC0
	bl	printf
	ldr	x30, [sp], 16
	.cfi_restore 30
	.cfi_def_cfa_offset 0
	mov	w0, 0
	ret
	.cfi_endproc
.LFE4361:
	.size	main, .-main
	.ident	"GCC: (Debian 12.2.0-14) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
