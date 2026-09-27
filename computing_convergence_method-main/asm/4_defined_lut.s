	.arch armv8-a
	.file	"4_defined_lut.c"
	.text
	.align	2
	.p2align 4,,15
	.global	log2_CCM
	.type	log2_CCM, %function
log2_CCM:
.LFB11:
	.cfi_startproc
	lsl	w1, w0, 1
	mov	w2, -32768
	cmp	w1, 32768
	csel	w1, w0, w1, gt
	add	w3, w1, w1, asr 1
	csel	w0, wzr, w2, gt
	cmp	w3, 32768
	bgt	.L3
	mov	w4, -19168
	mov	w1, w3
	add	w0, w0, w4
.L3:
	add	w5, w1, w1, asr 2
	cmp	w5, 32768
	bgt	.L4
	mov	w6, -10548
	mov	w1, w5
	add	w0, w0, w6
.L4:
	add	w7, w1, w1, asr 3
	cmp	w7, 32768
	bgt	.L5
	mov	w8, -5568
	mov	w1, w7
	add	w0, w0, w8
.L5:
	add	w9, w1, w1, asr 4
	cmp	w9, 32768
	bgt	.L6
	sub	w0, w0, #2865
	mov	w1, w9
.L6:
	add	w10, w1, w1, asr 5
	cmp	w10, 32768
	bgt	.L7
	sub	w0, w0, #1454
	mov	w1, w10
.L7:
	add	w11, w1, w1, asr 6
	cmp	w11, 32768
	bgt	.L8
	sub	w0, w0, #732
	mov	w1, w11
.L8:
	add	w12, w1, w1, asr 7
	cmp	w12, 32768
	bgt	.L9
	sub	w0, w0, #367
	mov	w1, w12
.L9:
	add	w13, w1, w1, asr 8
	cmp	w13, 32768
	bgt	.L10
	sub	w0, w0, #184
	mov	w1, w13
.L10:
	add	w14, w1, w1, asr 9
	cmp	w14, 32768
	bgt	.L11
	sub	w0, w0, #92
	mov	w1, w14
.L11:
	add	w15, w1, w1, asr 10
	cmp	w15, 32768
	bgt	.L12
	sub	w0, w0, #46
	mov	w1, w15
.L12:
	add	w16, w1, w1, asr 11
	cmp	w16, 32768
	bgt	.L13
	sub	w0, w0, #23
	mov	w1, w16
.L13:
	add	w17, w1, w1, asr 12
	cmp	w17, 32768
	bgt	.L14
	sub	w0, w0, #11
	mov	w1, w17
.L14:
	add	w18, w1, w1, asr 13
	cmp	w18, 32768
	bgt	.L15
	sub	w0, w0, #5
	mov	w1, w18
.L15:
	add	w3, w1, w1, asr 14
	sub	w2, w0, #2
	cmp	w3, 32768
	csel	w0, w2, w0, le
	ret
	.cfi_endproc
.LFE11:
	.size	log2_CCM, .-log2_CCM
	.section	.text.startup,"ax",@progbits
	.align	2
	.p2align 4,,15
	.global	main
	.type	main, %function
main:
.LFB12:
	.cfi_startproc
	mov	w0, 0
	ret
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.global	LUT
	.section	.rodata
	.align	4
	.type	LUT, %object
	.size	LUT, 60
LUT:
	.word	32768
	.word	19168
	.word	10548
	.word	5568
	.word	2865
	.word	1454
	.word	732
	.word	367
	.word	184
	.word	92
	.word	46
	.word	23
	.word	11
	.word	5
	.word	2
	.ident	"GCC: (Debian 12.2.0-14) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
