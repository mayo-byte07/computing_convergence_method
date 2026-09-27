	.arch armv8-a
	.file	"2_unoptimized.c"
	.text
	.align	2
	.global	calculate_lut
	.type	calculate_lut, %function
calculate_lut:
.LFB0:
	.cfi_startproc
	stp	x29, x30, [sp, -64]!
	.cfi_def_cfa_offset 64
	.cfi_offset 29, -64
	.cfi_offset 30, -56
	mov	x29, sp
	str	x19, [sp, 16]
	.cfi_offset 19, -48
	str	x0, [sp, 40]
	str	wzr, [sp, 60]
	b	.L2
.L3:
	ldr	w0, [sp, 60]
	neg	w0, w0
	scvtf	d0, w0
	fmov	d1, d0
	fmov	d0, 2.0e+0
	bl	pow
	fmov	d1, d0
	fmov	d0, 1.0e+0
	fadd	d0, d1, d0
	ldrsw	x0, [sp, 60]
	lsl	x0, x0, 3
	ldr	x1, [sp, 40]
	add	x19, x1, x0
	bl	log2
	str	d0, [x19]
	ldr	w0, [sp, 60]
	add	w0, w0, 1
	str	w0, [sp, 60]
.L2:
	ldr	w0, [sp, 60]
	cmp	w0, 14
	ble	.L3
	nop
	nop
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 64
	.cfi_restore 30
	.cfi_restore 29
	.cfi_restore 19
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE0:
	.size	calculate_lut, .-calculate_lut
	.align	2
	.global	log2_CCM
	.type	log2_CCM, %function
log2_CCM:
.LFB1:
	.cfi_startproc
	stp	x29, x30, [sp, -192]!
	.cfi_def_cfa_offset 192
	.cfi_offset 29, -192
	.cfi_offset 30, -184
	mov	x29, sp
	str	d0, [sp, 24]
	add	x0, sp, 32
	bl	calculate_lut
	str	xzr, [sp, 184]
	str	wzr, [sp, 180]
	b	.L5
.L8:
	ldr	w0, [sp, 180]
	neg	w0, w0
	scvtf	d0, w0
	fmov	d1, d0
	fmov	d0, 2.0e+0
	bl	pow
	fmov	d1, d0
	fmov	d0, 1.0e+0
	fadd	d0, d1, d0
	ldr	d1, [sp, 24]
	fmul	d0, d1, d0
	str	d0, [sp, 168]
	ldrsw	x0, [sp, 180]
	lsl	x0, x0, 3
	add	x1, sp, 32
	ldr	d0, [x1, x0]
	ldr	d1, [sp, 184]
	fsub	d0, d1, d0
	str	d0, [sp, 160]
	ldr	d1, [sp, 168]
	fmov	d0, 1.0e+0
	fcmpe	d1, d0
	bls	.L10
	b	.L6
.L10:
	ldr	d0, [sp, 168]
	str	d0, [sp, 24]
	ldr	d0, [sp, 160]
	str	d0, [sp, 184]
.L6:
	ldr	w0, [sp, 180]
	add	w0, w0, 1
	str	w0, [sp, 180]
.L5:
	ldr	w0, [sp, 180]
	cmp	w0, 14
	ble	.L8
	ldr	d0, [sp, 184]
	ldp	x29, x30, [sp], 192
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE1:
	.size	log2_CCM, .-log2_CCM
	.align	2
	.global	main
	.type	main, %function
main:
.LFB2:
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	mov	x0, 3689348814741910323
	movk	x0, 0x3fe3, lsl 48
	fmov	d0, x0
	str	d0, [sp, 8]
	mov	w0, 0
	add	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.ident	"GCC: (Debian 12.2.0-14) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
