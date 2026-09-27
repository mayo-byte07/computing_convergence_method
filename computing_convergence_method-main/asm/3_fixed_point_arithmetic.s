	.arch armv8-a
	.file	"3_fixed_point_arithmetic.c"
	.text
	.align	2
	.p2align 4,,15
	.global	calculate_lut
	.type	calculate_lut, %function
calculate_lut:
.LFB11:
	.cfi_startproc
	mov	x1, 4674736413210574848
	stp	x19, x20, [sp, -80]!
	.cfi_def_cfa_offset 80
	.cfi_offset 19, -80
	.cfi_offset 20, -72
	mov	x20, x0
	mov	x19, 0
	stp	d8, d9, [sp, 64]
	.cfi_offset 72, -16
	.cfi_offset 73, -8
	fmov	d9, 1.0e+0
	fmov	d8, x1
	stp	x21, x22, [sp, 16]
	stp	x23, x24, [sp, 32]
	str	x30, [sp, 48]
	.cfi_offset 21, -64
	.cfi_offset 22, -56
	.cfi_offset 23, -48
	.cfi_offset 24, -40
	.cfi_offset 30, -32
.L2:
	neg	w0, w19
	fmov	d0, 2.0e+0
	add	x21, x19, 1
	add	x23, x19, 3
	add	x24, x19, 2
	scvtf	d1, w0
	add	x22, x19, 4
	bl	pow
	fadd	d0, d0, d9
	bl	log2
	fmov	d2, d0
	mvn	w2, w19
	fmov	d0, 2.0e+0
	scvtf	d1, w2
	fmul	d3, d2, d8
	fcvtzs	w3, d3
	str	w3, [x20, x19, lsl 2]
	add	x19, x19, 5
	bl	pow
	fadd	d0, d0, d9
	bl	log2
	fmov	d4, d0
	mvn	w4, w21
	fmov	d0, 2.0e+0
	scvtf	d1, w4
	fmul	d5, d4, d8
	fcvtzs	w5, d5
	str	w5, [x20, x21, lsl 2]
	bl	pow
	fadd	d0, d0, d9
	bl	log2
	fmov	d6, d0
	neg	w6, w23
	fmov	d0, 2.0e+0
	scvtf	d1, w6
	fmul	d7, d6, d8
	fcvtzs	w7, d7
	str	w7, [x20, x24, lsl 2]
	bl	pow
	fadd	d0, d0, d9
	bl	log2
	fmov	d16, d0
	neg	w8, w22
	fmov	d0, 2.0e+0
	scvtf	d1, w8
	fmul	d17, d16, d8
	fcvtzs	w9, d17
	str	w9, [x20, x23, lsl 2]
	bl	pow
	fadd	d0, d0, d9
	bl	log2
	fmul	d0, d0, d8
	cmp	x19, 15
	fcvtzs	w10, d0
	str	w10, [x20, x22, lsl 2]
	bne	.L2
	ldp	x21, x22, [sp, 16]
	ldp	x23, x24, [sp, 32]
	ldr	x30, [sp, 48]
	ldp	d8, d9, [sp, 64]
	ldp	x19, x20, [sp], 80
	.cfi_restore 20
	.cfi_restore 19
	.cfi_restore 30
	.cfi_restore 23
	.cfi_restore 24
	.cfi_restore 21
	.cfi_restore 22
	.cfi_restore 72
	.cfi_restore 73
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE11:
	.size	calculate_lut, .-calculate_lut
	.align	2
	.p2align 4,,15
	.global	log2_CCM
	.type	log2_CCM, %function
log2_CCM:
.LFB12:
	.cfi_startproc
	mov	x1, 4674736413210574848
	stp	x19, x20, [sp, -160]!
	.cfi_def_cfa_offset 160
	.cfi_offset 19, -160
	.cfi_offset 20, -152
	mov	x20, 1
	mov	w19, w0
	stp	d8, d9, [sp, 80]
	.cfi_offset 72, -80
	.cfi_offset 73, -72
	fmov	d9, 1.0e+0
	fmov	d8, x1
	stp	x21, x22, [sp, 16]
	.cfi_offset 21, -144
	.cfi_offset 22, -136
	add	x22, sp, 96
	stp	x23, x24, [sp, 32]
	.cfi_offset 23, -128
	.cfi_offset 24, -120
	mov	w23, w20
	stp	x25, x26, [sp, 48]
	str	x30, [sp, 64]
	.cfi_offset 25, -112
	.cfi_offset 26, -104
	.cfi_offset 30, -96
.L11:
	sub	w0, w23, w20
	fmov	d0, 2.0e+0
	add	x21, x20, 1
	add	x26, x20, 2
	add	x25, x20, 3
	scvtf	d1, w0
	add	x24, x20, 4
	bl	pow
	fadd	d0, d0, d9
	bl	log2
	fmov	d2, d0
	sub	w3, w23, w21
	add	x2, x22, x20, lsl 2
	fmov	d0, 2.0e+0
	add	x21, x22, x21, lsl 2
	add	x20, x20, 5
	scvtf	d1, w3
	fmul	d3, d2, d8
	fcvtzs	w4, d3
	str	w4, [x2, -4]
	bl	pow
	fadd	d0, d0, d9
	bl	log2
	fmov	d4, d0
	sub	w5, w23, w26
	fmov	d0, 2.0e+0
	add	x26, x22, x26, lsl 2
	scvtf	d1, w5
	fmul	d5, d4, d8
	fcvtzs	w6, d5
	str	w6, [x21, -4]
	bl	pow
	fadd	d0, d0, d9
	bl	log2
	fmov	d6, d0
	sub	w7, w23, w25
	fmov	d0, 2.0e+0
	add	x25, x22, x25, lsl 2
	scvtf	d1, w7
	fmul	d7, d6, d8
	fcvtzs	w8, d7
	str	w8, [x26, -4]
	bl	pow
	fadd	d0, d0, d9
	bl	log2
	fmov	d16, d0
	sub	w9, w23, w24
	fmov	d0, 2.0e+0
	add	x24, x22, x24, lsl 2
	scvtf	d1, w9
	fmul	d17, d16, d8
	fcvtzs	w10, d17
	str	w10, [x25, -4]
	bl	pow
	fadd	d0, d0, d9
	bl	log2
	fmul	d0, d0, d8
	cmp	x20, 16
	fcvtzs	w11, d0
	str	w11, [x24, -4]
	bne	.L11
	lsl	w12, w19, 1
	ldr	w13, [sp, 96]
	mov	w1, 0
	cmp	w12, 32768
	bgt	.L12
	neg	w1, w13
	mov	w19, w12
.L12:
	add	w14, w19, w19, asr 1
	ldr	w15, [sp, 100]
	cmp	w14, 32768
	bgt	.L13
	sub	w1, w1, w15
	mov	w19, w14
.L13:
	add	w16, w19, w19, asr 2
	ldr	w17, [sp, 104]
	cmp	w16, 32768
	bgt	.L14
	sub	w1, w1, w17
	mov	w19, w16
.L14:
	add	w18, w19, w19, asr 3
	ldr	w30, [sp, 108]
	cmp	w18, 32768
	bgt	.L15
	sub	w1, w1, w30
	mov	w19, w18
.L15:
	add	w23, w19, w19, asr 4
	ldr	w22, [sp, 112]
	cmp	w23, 32768
	bgt	.L16
	sub	w1, w1, w22
	mov	w19, w23
.L16:
	add	w0, w19, w19, asr 5
	ldr	w2, [sp, 116]
	cmp	w0, 32768
	bgt	.L17
	sub	w1, w1, w2
	mov	w19, w0
.L17:
	add	w3, w19, w19, asr 6
	ldr	w20, [sp, 120]
	cmp	w3, 32768
	bgt	.L18
	sub	w1, w1, w20
	mov	w19, w3
.L18:
	add	w4, w19, w19, asr 7
	ldr	w21, [sp, 124]
	cmp	w4, 32768
	bgt	.L19
	sub	w1, w1, w21
	mov	w19, w4
.L19:
	add	w5, w19, w19, asr 8
	ldr	w6, [sp, 128]
	cmp	w5, 32768
	bgt	.L20
	sub	w1, w1, w6
	mov	w19, w5
.L20:
	add	w26, w19, w19, asr 9
	ldr	w7, [sp, 132]
	cmp	w26, 32768
	bgt	.L21
	sub	w1, w1, w7
	mov	w19, w26
.L21:
	add	w8, w19, w19, asr 10
	ldr	w25, [sp, 136]
	cmp	w8, 32768
	bgt	.L22
	sub	w1, w1, w25
	mov	w19, w8
.L22:
	add	w9, w19, w19, asr 11
	ldr	w10, [sp, 140]
	cmp	w9, 32768
	bgt	.L23
	sub	w1, w1, w10
	mov	w19, w9
.L23:
	add	w24, w19, w19, asr 12
	ldr	w11, [sp, 144]
	cmp	w24, 32768
	bgt	.L24
	sub	w1, w1, w11
	mov	w19, w24
.L24:
	add	w12, w19, w19, asr 13
	ldr	w13, [sp, 148]
	cmp	w12, 32768
	bgt	.L25
	sub	w1, w1, w13
	mov	w19, w12
.L25:
	ldr	w15, [sp, 152]
	add	w14, w19, w19, asr 14
	ldp	x21, x22, [sp, 16]
	cmp	w14, 32768
	ldp	x23, x24, [sp, 32]
	sub	w16, w1, w15
	csel	w0, w16, w1, le
	ldp	x25, x26, [sp, 48]
	ldr	x30, [sp, 64]
	ldp	d8, d9, [sp, 80]
	ldp	x19, x20, [sp], 160
	.cfi_restore 20
	.cfi_restore 19
	.cfi_restore 30
	.cfi_restore 25
	.cfi_restore 26
	.cfi_restore 23
	.cfi_restore 24
	.cfi_restore 21
	.cfi_restore 22
	.cfi_restore 72
	.cfi_restore 73
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE12:
	.size	log2_CCM, .-log2_CCM
	.section	.text.startup,"ax",@progbits
	.align	2
	.p2align 4,,15
	.global	main
	.type	main, %function
main:
.LFB13:
	.cfi_startproc
	mov	w0, 19660
	str	x30, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 30, -16
	bl	log2_CCM
	ldr	x30, [sp], 16
	.cfi_restore 30
	.cfi_def_cfa_offset 0
	mov	w0, 0
	ret
	.cfi_endproc
.LFE13:
	.size	main, .-main
	.ident	"GCC: (Debian 12.2.0-14) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
