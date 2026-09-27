	.arch armv8-a
	.file	"accuracy_tester.c"
	.text
	.align	2
	.p2align 4,,15
	.global	ccm
	.type	ccm, %function
ccm:
.LFB4372:
	.cfi_startproc
	fcvtzs	w1, d0, #15
	mov	w2, 32767
	cmp	w1, w2
	ble	.L2
	mov	w4, 0
	.p2align 3,,7
.L3:
	asr	w1, w1, 1
	add	w4, w4, 1
	cmp	w1, w2
	bgt	.L3
	cmp	w1, 16384
	mov	w3, 0
	lsl	w6, w4, 15
	beq	.L24
.L5:
	add	w0, w1, w1, asr 1
	cmp	w0, 32768
	bgt	.L21
	mov	w5, -19168
	add	w3, w3, w5
.L6:
	add	w7, w0, w0, asr 2
	cmp	w7, 32768
	bgt	.L4
	mov	w8, -10548
	mov	w0, w7
	add	w3, w3, w8
.L4:
	add	w9, w0, w0, asr 3
	cmp	w9, 32768
	bgt	.L7
	mov	w10, -5568
	mov	w0, w9
	add	w3, w3, w10
.L7:
	add	w11, w0, w0, asr 4
	cmp	w11, 32768
	bgt	.L8
	sub	w3, w3, #2865
	mov	w0, w11
.L8:
	add	w12, w0, w0, asr 5
	cmp	w12, 32768
	bgt	.L9
	sub	w3, w3, #1454
	mov	w0, w12
.L9:
	add	w13, w0, w0, asr 6
	cmp	w13, 32768
	bgt	.L10
	sub	w3, w3, #732
	mov	w0, w13
.L10:
	add	w14, w0, w0, asr 7
	cmp	w14, 32768
	bgt	.L11
	sub	w3, w3, #367
	mov	w0, w14
.L11:
	add	w15, w0, w0, asr 8
	cmp	w15, 32768
	bgt	.L12
	sub	w3, w3, #184
	mov	w0, w15
.L12:
	add	w16, w0, w0, asr 9
	cmp	w16, 32768
	bgt	.L13
	sub	w3, w3, #92
	mov	w0, w16
.L13:
	add	w17, w0, w0, asr 10
	cmp	w17, 32768
	bgt	.L14
	sub	w3, w3, #46
	mov	w0, w17
.L14:
	add	w18, w0, w0, asr 11
	cmp	w18, 32768
	bgt	.L15
	sub	w3, w3, #23
	mov	w0, w18
.L15:
	add	w2, w0, w0, asr 12
	cmp	w2, 32768
	bgt	.L16
	sub	w3, w3, #11
	mov	w0, w2
.L16:
	add	w1, w0, w0, asr 13
	cmp	w1, 32768
	bgt	.L17
	sub	w3, w3, #5
	mov	w0, w1
.L17:
	add	w4, w0, w0, asr 14
	sub	w5, w3, #2
	cmp	w4, 32768
	csel	w7, w5, w3, le
	add	w6, w7, w6
	scvtf	d0, w6, #15
	ret
	.p2align 2,,3
.L24:
	mov	w0, 32768
	mov	w3, -32768
	b	.L4
	.p2align 2,,3
.L2:
	lsl	w0, w1, 1
	mov	w3, -32768
	cmp	w0, 32768
	mov	w6, 0
	csel	w1, w1, w0, gt
	csel	w3, wzr, w3, gt
	b	.L5
.L21:
	mov	w0, w1
	b	.L6
	.cfi_endproc
.LFE4372:
	.size	ccm, .-ccm
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"TEST CASE %d:\n-----\n"
	.align	3
.LC1:
	.string	"Randomly chosen input: %f\n"
	.align	3
.LC2:
	.string	"CCM log2: %f\n"
	.align	3
.LC3:
	.string	"True log2: %f\n"
	.align	3
.LC4:
	.string	"Percent difference: %f%%\n\n"
	.align	3
.LC5:
	.string	"MEAN OVERALL PERCENTAGE DIFFERENCE: %f%%\n"
	.section	.text.startup,"ax",@progbits
	.align	2
	.p2align 4,,15
	.global	main
	.type	main, %function
main:
.LFB4373:
	.cfi_startproc
	mov	x1, 281474972516352
	mov	x0, 4636737291354636288
	stp	x19, x20, [sp, -128]!
	.cfi_def_cfa_offset 128
	.cfi_offset 19, -128
	.cfi_offset 20, -120
	movk	x1, 0x41df, lsl 48
	adrp	x2, .LC6
	adrp	x20, .LC0
	mov	w19, 0
	stp	d8, d9, [sp, 64]
	add	x20, x20, :lo12:.LC0
	.cfi_offset 72, -64
	.cfi_offset 73, -56
	fmov	d9, x0
	stp	d10, d11, [sp, 80]
	.cfi_offset 74, -48
	.cfi_offset 75, -40
	movi	d10, #0
	fmov	d11, x1
	stp	d12, d13, [sp, 96]
	.cfi_offset 76, -32
	.cfi_offset 77, -24
	ldr	d12, [x2, #:lo12:.LC6]
	stp	x21, x22, [sp, 16]
	.cfi_offset 21, -112
	.cfi_offset 22, -104
	adrp	x22, .LC3
	adrp	x21, .LC4
	stp	x23, x24, [sp, 32]
	.cfi_offset 23, -96
	.cfi_offset 24, -88
	adrp	x24, .LC1
	adrp	x23, .LC2
	str	x30, [sp, 48]
	stp	d14, d15, [sp, 112]
	.cfi_offset 30, -80
	.cfi_offset 78, -16
	.cfi_offset 79, -8
	.p2align 3,,7
.L30:
	bl	rand
	scvtf	d8, w0
	fdiv	d0, d8, d11
	fmul	d8, d0, d9
	fcmpe	d8, d12
	bmi	.L31
	b	.L26
	.p2align 2,,3
.L31:
	adrp	x3, .LC7
	ldr	d1, [x3, #:lo12:.LC7]
	fcmpe	d8, d1
	bgt	.L30
.L26:
	fmov	d0, d8
	add	w19, w19, 1
	bl	ccm
	fmov	d15, d0
	fmov	d0, d8
	bl	log2
	fsub	d14, d15, d0
	fmov	d13, d0
	mov	w1, w19
	mov	x0, x20
	fdiv	d2, d14, d0
	fabs	d3, d2
	fmul	d14, d3, d9
	bl	printf
	fmov	d0, d8
	add	x0, x24, :lo12:.LC1
	bl	printf
	fadd	d10, d10, d14
	fmov	d0, d15
	add	x0, x23, :lo12:.LC2
	bl	printf
	fmov	d0, d13
	add	x0, x22, :lo12:.LC3
	bl	printf
	fmov	d0, d14
	add	x0, x21, :lo12:.LC4
	bl	printf
	cmp	w19, 1000
	bne	.L30
	mov	x4, 70368744177664
	adrp	x5, .LC5
	add	x0, x5, :lo12:.LC5
	movk	x4, 0x408f, lsl 48
	fmov	d4, x4
	fdiv	d0, d10, d4
	bl	printf
	ldp	x21, x22, [sp, 16]
	mov	w0, 0
	ldp	x23, x24, [sp, 32]
	ldr	x30, [sp, 48]
	ldp	d8, d9, [sp, 64]
	ldp	d10, d11, [sp, 80]
	ldp	d12, d13, [sp, 96]
	ldp	d14, d15, [sp, 112]
	ldp	x19, x20, [sp], 128
	.cfi_restore 20
	.cfi_restore 19
	.cfi_restore 30
	.cfi_restore 23
	.cfi_restore 24
	.cfi_restore 21
	.cfi_restore 22
	.cfi_restore 78
	.cfi_restore 79
	.cfi_restore 76
	.cfi_restore 77
	.cfi_restore 74
	.cfi_restore 75
	.cfi_restore 72
	.cfi_restore 73
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE4373:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align	3
.LC6:
	.word	-1717986918
	.word	1071749529
	.align	3
.LC7:
	.word	-343597384
	.word	1071560785
	.ident	"GCC: (Debian 12.2.0-14) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
