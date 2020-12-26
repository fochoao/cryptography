; Listing generated by Microsoft (R) Optimizing Compiler Version 19.00.24210.0 

	TITLE	C:\CPython\externals\zlib-1.2.11\adler32.c
	.686P
	.XMM
	include listing.inc
	.model	flat

INCLUDELIB MSVCRTD
INCLUDELIB OLDNAMES

PUBLIC	_adler32@12
PUBLIC	_adler32_z@12
PUBLIC	_adler32_combine@12
PUBLIC	_adler32_combine64@16
EXTRN	__allrem:PROC
; Function compile flags: /Odtp
; File c:\cpython\externals\zlib-1.2.11\adler32.c
_TEXT	SEGMENT
_adler1$ = 8						; size = 4
_adler2$ = 12						; size = 4
_len2$ = 16						; size = 8
_adler32_combine64@16 PROC

; 184  : {

	push	ebp
	mov	ebp, esp

; 185  :     return adler32_combine_(adler1, adler2, len2);

	mov	eax, DWORD PTR _len2$[ebp+4]
	push	eax
	mov	ecx, DWORD PTR _len2$[ebp]
	push	ecx
	mov	edx, DWORD PTR _adler2$[ebp]
	push	edx
	mov	eax, DWORD PTR _adler1$[ebp]
	push	eax
	call	_adler32_combine_
	add	esp, 16					; 00000010H

; 186  : }

	pop	ebp
	ret	16					; 00000010H
_adler32_combine64@16 ENDP
_TEXT	ENDS
; Function compile flags: /Odtp
; File c:\cpython\externals\zlib-1.2.11\adler32.c
_TEXT	SEGMENT
_rem$ = -12						; size = 4
_sum1$ = -8						; size = 4
_sum2$ = -4						; size = 4
_adler1$ = 8						; size = 4
_adler2$ = 12						; size = 4
_len2$ = 16						; size = 8
_adler32_combine_ PROC

; 147  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 12					; 0000000cH

; 148  :     unsigned long sum1;
; 149  :     unsigned long sum2;
; 150  :     unsigned rem;
; 151  : 
; 152  :     /* for negative len, return invalid adler32 as a clue for debugging */
; 153  :     if (len2 < 0)

	cmp	DWORD PTR _len2$[ebp+4], 0
	jg	SHORT $LN2@adler32_co
	jl	SHORT $LN8@adler32_co
	cmp	DWORD PTR _len2$[ebp], 0
	jae	SHORT $LN2@adler32_co
$LN8@adler32_co:

; 154  :         return 0xffffffffUL;

	or	eax, -1
	jmp	$LN1@adler32_co
$LN2@adler32_co:

; 155  : 
; 156  :     /* the derivation of this formula is left as an exercise for the reader */
; 157  :     MOD63(len2);                /* assumes len2 >= 0 */

	push	0
	push	65521					; 0000fff1H
	mov	eax, DWORD PTR _len2$[ebp+4]
	push	eax
	mov	ecx, DWORD PTR _len2$[ebp]
	push	ecx
	call	__allrem
	mov	DWORD PTR _len2$[ebp], eax
	mov	DWORD PTR _len2$[ebp+4], edx

; 158  :     rem = (unsigned)len2;

	mov	edx, DWORD PTR _len2$[ebp]
	mov	DWORD PTR _rem$[ebp], edx

; 159  :     sum1 = adler1 & 0xffff;

	mov	eax, DWORD PTR _adler1$[ebp]
	and	eax, 65535				; 0000ffffH
	mov	DWORD PTR _sum1$[ebp], eax

; 160  :     sum2 = rem * sum1;

	mov	ecx, DWORD PTR _rem$[ebp]
	imul	ecx, DWORD PTR _sum1$[ebp]
	mov	DWORD PTR _sum2$[ebp], ecx

; 161  :     MOD(sum2);

	mov	eax, DWORD PTR _sum2$[ebp]
	xor	edx, edx
	mov	ecx, 65521				; 0000fff1H
	div	ecx
	mov	DWORD PTR _sum2$[ebp], edx

; 162  :     sum1 += (adler2 & 0xffff) + BASE - 1;

	mov	edx, DWORD PTR _adler2$[ebp]
	and	edx, 65535				; 0000ffffH
	mov	eax, DWORD PTR _sum1$[ebp]
	lea	ecx, DWORD PTR [eax+edx+65520]
	mov	DWORD PTR _sum1$[ebp], ecx

; 163  :     sum2 += ((adler1 >> 16) & 0xffff) + ((adler2 >> 16) & 0xffff) + BASE - rem;

	mov	edx, DWORD PTR _adler1$[ebp]
	shr	edx, 16					; 00000010H
	and	edx, 65535				; 0000ffffH
	mov	eax, DWORD PTR _adler2$[ebp]
	shr	eax, 16					; 00000010H
	and	eax, 65535				; 0000ffffH
	lea	ecx, DWORD PTR [edx+eax+65521]
	sub	ecx, DWORD PTR _rem$[ebp]
	add	ecx, DWORD PTR _sum2$[ebp]
	mov	DWORD PTR _sum2$[ebp], ecx

; 164  :     if (sum1 >= BASE) sum1 -= BASE;

	cmp	DWORD PTR _sum1$[ebp], 65521		; 0000fff1H
	jb	SHORT $LN3@adler32_co
	mov	edx, DWORD PTR _sum1$[ebp]
	sub	edx, 65521				; 0000fff1H
	mov	DWORD PTR _sum1$[ebp], edx
$LN3@adler32_co:

; 165  :     if (sum1 >= BASE) sum1 -= BASE;

	cmp	DWORD PTR _sum1$[ebp], 65521		; 0000fff1H
	jb	SHORT $LN4@adler32_co
	mov	eax, DWORD PTR _sum1$[ebp]
	sub	eax, 65521				; 0000fff1H
	mov	DWORD PTR _sum1$[ebp], eax
$LN4@adler32_co:

; 166  :     if (sum2 >= ((unsigned long)BASE << 1)) sum2 -= ((unsigned long)BASE << 1);

	cmp	DWORD PTR _sum2$[ebp], 131042		; 0001ffe2H
	jb	SHORT $LN5@adler32_co
	mov	ecx, DWORD PTR _sum2$[ebp]
	sub	ecx, 131042				; 0001ffe2H
	mov	DWORD PTR _sum2$[ebp], ecx
$LN5@adler32_co:

; 167  :     if (sum2 >= BASE) sum2 -= BASE;

	cmp	DWORD PTR _sum2$[ebp], 65521		; 0000fff1H
	jb	SHORT $LN6@adler32_co
	mov	edx, DWORD PTR _sum2$[ebp]
	sub	edx, 65521				; 0000fff1H
	mov	DWORD PTR _sum2$[ebp], edx
$LN6@adler32_co:

; 168  :     return sum1 | (sum2 << 16);

	mov	eax, DWORD PTR _sum2$[ebp]
	shl	eax, 16					; 00000010H
	or	eax, DWORD PTR _sum1$[ebp]
$LN1@adler32_co:

; 169  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_adler32_combine_ ENDP
_TEXT	ENDS
; Function compile flags: /Odtp
; File c:\cpython\externals\zlib-1.2.11\adler32.c
_TEXT	SEGMENT
_adler1$ = 8						; size = 4
_adler2$ = 12						; size = 4
_len2$ = 16						; size = 4
_adler32_combine@12 PROC

; 176  : {

	push	ebp
	mov	ebp, esp

; 177  :     return adler32_combine_(adler1, adler2, len2);

	mov	eax, DWORD PTR _len2$[ebp]
	cdq
	push	edx
	push	eax
	mov	eax, DWORD PTR _adler2$[ebp]
	push	eax
	mov	ecx, DWORD PTR _adler1$[ebp]
	push	ecx
	call	_adler32_combine_
	add	esp, 16					; 00000010H

; 178  : }

	pop	ebp
	ret	12					; 0000000cH
_adler32_combine@12 ENDP
_TEXT	ENDS
; Function compile flags: /Odtp
; File c:\cpython\externals\zlib-1.2.11\adler32.c
_TEXT	SEGMENT
tv298 = -16						; size = 4
tv83 = -12						; size = 4
_n$ = -8						; size = 4
_sum2$ = -4						; size = 4
_adler$ = 8						; size = 4
_buf$ = 12						; size = 4
_len$ = 16						; size = 4
_adler32_z@12 PROC

; 67   : {

	push	ebp
	mov	ebp, esp
	sub	esp, 16					; 00000010H

; 68   :     unsigned long sum2;
; 69   :     unsigned n;
; 70   : 
; 71   :     /* split Adler-32 into component sums */
; 72   :     sum2 = (adler >> 16) & 0xffff;

	mov	eax, DWORD PTR _adler$[ebp]
	shr	eax, 16					; 00000010H
	and	eax, 65535				; 0000ffffH
	mov	DWORD PTR _sum2$[ebp], eax

; 73   :     adler &= 0xffff;

	mov	ecx, DWORD PTR _adler$[ebp]
	and	ecx, 65535				; 0000ffffH
	mov	DWORD PTR _adler$[ebp], ecx

; 74   : 
; 75   :     /* in case user likes doing a byte at a time, keep it fast */
; 76   :     if (len == 1) {

	cmp	DWORD PTR _len$[ebp], 1
	jne	SHORT $LN13@adler32_z

; 77   :         adler += buf[0];

	mov	edx, 1
	imul	eax, edx, 0
	mov	ecx, DWORD PTR _buf$[ebp]
	movzx	edx, BYTE PTR [ecx+eax]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], edx

; 78   :         if (adler >= BASE)

	cmp	DWORD PTR _adler$[ebp], 65521		; 0000fff1H
	jb	SHORT $LN14@adler32_z

; 79   :             adler -= BASE;

	mov	eax, DWORD PTR _adler$[ebp]
	sub	eax, 65521				; 0000fff1H
	mov	DWORD PTR _adler$[ebp], eax
$LN14@adler32_z:

; 80   :         sum2 += adler;

	mov	ecx, DWORD PTR _sum2$[ebp]
	add	ecx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], ecx

; 81   :         if (sum2 >= BASE)

	cmp	DWORD PTR _sum2$[ebp], 65521		; 0000fff1H
	jb	SHORT $LN15@adler32_z

; 82   :             sum2 -= BASE;

	mov	edx, DWORD PTR _sum2$[ebp]
	sub	edx, 65521				; 0000fff1H
	mov	DWORD PTR _sum2$[ebp], edx
$LN15@adler32_z:

; 83   :         return adler | (sum2 << 16);

	mov	eax, DWORD PTR _sum2$[ebp]
	shl	eax, 16					; 00000010H
	or	eax, DWORD PTR _adler$[ebp]
	jmp	$LN1@adler32_z
$LN13@adler32_z:

; 84   :     }
; 85   : 
; 86   :     /* initial Adler-32 value (deferred check for len == 1 speed) */
; 87   :     if (buf == Z_NULL)

	cmp	DWORD PTR _buf$[ebp], 0
	jne	SHORT $LN16@adler32_z

; 88   :         return 1L;

	mov	eax, 1
	jmp	$LN1@adler32_z
$LN16@adler32_z:

; 89   : 
; 90   :     /* in case short lengths are provided, keep it somewhat fast */
; 91   :     if (len < 16) {

	cmp	DWORD PTR _len$[ebp], 16		; 00000010H
	jae	SHORT $LN4@adler32_z
$LN2@adler32_z:

; 92   :         while (len--) {

	mov	eax, DWORD PTR _len$[ebp]
	mov	DWORD PTR tv83[ebp], eax
	mov	ecx, DWORD PTR _len$[ebp]
	sub	ecx, 1
	mov	DWORD PTR _len$[ebp], ecx
	cmp	DWORD PTR tv83[ebp], 0
	je	SHORT $LN3@adler32_z

; 93   :             adler += *buf++;

	mov	edx, DWORD PTR _buf$[ebp]
	movzx	eax, BYTE PTR [edx]
	add	eax, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], eax
	mov	ecx, DWORD PTR _buf$[ebp]
	add	ecx, 1
	mov	DWORD PTR _buf$[ebp], ecx

; 94   :             sum2 += adler;

	mov	edx, DWORD PTR _sum2$[ebp]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], edx

; 95   :         }

	jmp	SHORT $LN2@adler32_z
$LN3@adler32_z:

; 96   :         if (adler >= BASE)

	cmp	DWORD PTR _adler$[ebp], 65521		; 0000fff1H
	jb	SHORT $LN18@adler32_z

; 97   :             adler -= BASE;

	mov	eax, DWORD PTR _adler$[ebp]
	sub	eax, 65521				; 0000fff1H
	mov	DWORD PTR _adler$[ebp], eax
$LN18@adler32_z:

; 98   :         MOD28(sum2);            /* only added so many BASE's */

	mov	eax, DWORD PTR _sum2$[ebp]
	xor	edx, edx
	mov	ecx, 65521				; 0000fff1H
	div	ecx
	mov	DWORD PTR _sum2$[ebp], edx

; 99   :         return adler | (sum2 << 16);

	mov	eax, DWORD PTR _sum2$[ebp]
	shl	eax, 16					; 00000010H
	or	eax, DWORD PTR _adler$[ebp]
	jmp	$LN1@adler32_z
$LN4@adler32_z:

; 100  :     }
; 101  : 
; 102  :     /* do length NMAX blocks -- requires just one modulo operation */
; 103  :     while (len >= NMAX) {

	cmp	DWORD PTR _len$[ebp], 5552		; 000015b0H
	jb	$LN5@adler32_z

; 104  :         len -= NMAX;

	mov	edx, DWORD PTR _len$[ebp]
	sub	edx, 5552				; 000015b0H
	mov	DWORD PTR _len$[ebp], edx

; 105  :         n = NMAX / 16;          /* NMAX is divisible by 16 */

	mov	DWORD PTR _n$[ebp], 347			; 0000015bH
$LN8@adler32_z:

; 106  :         do {
; 107  :             DO16(buf);          /* 16 sums unrolled */

	mov	eax, 1
	imul	ecx, eax, 0
	mov	edx, DWORD PTR _buf$[ebp]
	movzx	eax, BYTE PTR [edx+ecx]
	add	eax, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], eax
	mov	ecx, DWORD PTR _sum2$[ebp]
	add	ecx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], ecx
	mov	edx, 1
	shl	edx, 0
	mov	eax, DWORD PTR _buf$[ebp]
	movzx	ecx, BYTE PTR [eax+edx]
	add	ecx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], ecx
	mov	edx, DWORD PTR _sum2$[ebp]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], edx
	mov	eax, 1
	shl	eax, 1
	mov	ecx, DWORD PTR _buf$[ebp]
	movzx	edx, BYTE PTR [ecx+eax]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], edx
	mov	eax, DWORD PTR _sum2$[ebp]
	add	eax, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], eax
	mov	ecx, 1
	imul	edx, ecx, 3
	mov	eax, DWORD PTR _buf$[ebp]
	movzx	ecx, BYTE PTR [eax+edx]
	add	ecx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], ecx
	mov	edx, DWORD PTR _sum2$[ebp]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], edx
	mov	eax, 1
	shl	eax, 2
	mov	ecx, DWORD PTR _buf$[ebp]
	movzx	edx, BYTE PTR [ecx+eax]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], edx
	mov	eax, DWORD PTR _sum2$[ebp]
	add	eax, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], eax
	mov	ecx, 1
	imul	edx, ecx, 5
	mov	eax, DWORD PTR _buf$[ebp]
	movzx	ecx, BYTE PTR [eax+edx]
	add	ecx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], ecx
	mov	edx, DWORD PTR _sum2$[ebp]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], edx
	mov	eax, 1
	imul	ecx, eax, 6
	mov	edx, DWORD PTR _buf$[ebp]
	movzx	eax, BYTE PTR [edx+ecx]
	add	eax, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], eax
	mov	ecx, DWORD PTR _sum2$[ebp]
	add	ecx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], ecx
	mov	edx, 1
	imul	eax, edx, 7
	mov	ecx, DWORD PTR _buf$[ebp]
	movzx	edx, BYTE PTR [ecx+eax]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], edx
	mov	eax, DWORD PTR _sum2$[ebp]
	add	eax, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], eax
	mov	ecx, 1
	shl	ecx, 3
	mov	edx, DWORD PTR _buf$[ebp]
	movzx	eax, BYTE PTR [edx+ecx]
	add	eax, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], eax
	mov	ecx, DWORD PTR _sum2$[ebp]
	add	ecx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], ecx
	mov	edx, 1
	imul	eax, edx, 9
	mov	ecx, DWORD PTR _buf$[ebp]
	movzx	edx, BYTE PTR [ecx+eax]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], edx
	mov	eax, DWORD PTR _sum2$[ebp]
	add	eax, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], eax
	mov	ecx, 1
	imul	edx, ecx, 10
	mov	eax, DWORD PTR _buf$[ebp]
	movzx	ecx, BYTE PTR [eax+edx]
	add	ecx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], ecx
	mov	edx, DWORD PTR _sum2$[ebp]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], edx
	mov	eax, 1
	imul	ecx, eax, 11
	mov	edx, DWORD PTR _buf$[ebp]
	movzx	eax, BYTE PTR [edx+ecx]
	add	eax, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], eax
	mov	ecx, DWORD PTR _sum2$[ebp]
	add	ecx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], ecx
	mov	edx, 1
	imul	eax, edx, 12
	mov	ecx, DWORD PTR _buf$[ebp]
	movzx	edx, BYTE PTR [ecx+eax]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], edx
	mov	eax, DWORD PTR _sum2$[ebp]
	add	eax, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], eax
	mov	ecx, 1
	imul	edx, ecx, 13
	mov	eax, DWORD PTR _buf$[ebp]
	movzx	ecx, BYTE PTR [eax+edx]
	add	ecx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], ecx
	mov	edx, DWORD PTR _sum2$[ebp]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], edx
	mov	eax, 1
	imul	ecx, eax, 14
	mov	edx, DWORD PTR _buf$[ebp]
	movzx	eax, BYTE PTR [edx+ecx]
	add	eax, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], eax
	mov	ecx, DWORD PTR _sum2$[ebp]
	add	ecx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], ecx
	mov	edx, 1
	imul	eax, edx, 15
	mov	ecx, DWORD PTR _buf$[ebp]
	movzx	edx, BYTE PTR [ecx+eax]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], edx
	mov	eax, DWORD PTR _sum2$[ebp]
	add	eax, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], eax

; 108  :             buf += 16;

	mov	ecx, DWORD PTR _buf$[ebp]
	add	ecx, 16					; 00000010H
	mov	DWORD PTR _buf$[ebp], ecx

; 109  :         } while (--n);

	mov	edx, DWORD PTR _n$[ebp]
	sub	edx, 1
	mov	DWORD PTR _n$[ebp], edx
	jne	$LN8@adler32_z

; 110  :         MOD(adler);

	mov	eax, DWORD PTR _adler$[ebp]
	xor	edx, edx
	mov	ecx, 65521				; 0000fff1H
	div	ecx
	mov	DWORD PTR _adler$[ebp], edx

; 111  :         MOD(sum2);

	mov	eax, DWORD PTR _sum2$[ebp]
	xor	edx, edx
	mov	ecx, 65521				; 0000fff1H
	div	ecx
	mov	DWORD PTR _sum2$[ebp], edx

; 112  :     }

	jmp	$LN4@adler32_z
$LN5@adler32_z:

; 113  : 
; 114  :     /* do remaining bytes (less than NMAX, still just one modulo) */
; 115  :     if (len) {                  /* avoid modulos if none remaining */

	cmp	DWORD PTR _len$[ebp], 0
	je	$LN19@adler32_z
$LN9@adler32_z:

; 116  :         while (len >= 16) {

	cmp	DWORD PTR _len$[ebp], 16		; 00000010H
	jb	$LN11@adler32_z

; 117  :             len -= 16;

	mov	edx, DWORD PTR _len$[ebp]
	sub	edx, 16					; 00000010H
	mov	DWORD PTR _len$[ebp], edx

; 118  :             DO16(buf);

	mov	eax, 1
	imul	ecx, eax, 0
	mov	edx, DWORD PTR _buf$[ebp]
	movzx	eax, BYTE PTR [edx+ecx]
	add	eax, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], eax
	mov	ecx, DWORD PTR _sum2$[ebp]
	add	ecx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], ecx
	mov	edx, 1
	shl	edx, 0
	mov	eax, DWORD PTR _buf$[ebp]
	movzx	ecx, BYTE PTR [eax+edx]
	add	ecx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], ecx
	mov	edx, DWORD PTR _sum2$[ebp]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], edx
	mov	eax, 1
	shl	eax, 1
	mov	ecx, DWORD PTR _buf$[ebp]
	movzx	edx, BYTE PTR [ecx+eax]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], edx
	mov	eax, DWORD PTR _sum2$[ebp]
	add	eax, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], eax
	mov	ecx, 1
	imul	edx, ecx, 3
	mov	eax, DWORD PTR _buf$[ebp]
	movzx	ecx, BYTE PTR [eax+edx]
	add	ecx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], ecx
	mov	edx, DWORD PTR _sum2$[ebp]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], edx
	mov	eax, 1
	shl	eax, 2
	mov	ecx, DWORD PTR _buf$[ebp]
	movzx	edx, BYTE PTR [ecx+eax]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], edx
	mov	eax, DWORD PTR _sum2$[ebp]
	add	eax, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], eax
	mov	ecx, 1
	imul	edx, ecx, 5
	mov	eax, DWORD PTR _buf$[ebp]
	movzx	ecx, BYTE PTR [eax+edx]
	add	ecx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], ecx
	mov	edx, DWORD PTR _sum2$[ebp]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], edx
	mov	eax, 1
	imul	ecx, eax, 6
	mov	edx, DWORD PTR _buf$[ebp]
	movzx	eax, BYTE PTR [edx+ecx]
	add	eax, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], eax
	mov	ecx, DWORD PTR _sum2$[ebp]
	add	ecx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], ecx
	mov	edx, 1
	imul	eax, edx, 7
	mov	ecx, DWORD PTR _buf$[ebp]
	movzx	edx, BYTE PTR [ecx+eax]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], edx
	mov	eax, DWORD PTR _sum2$[ebp]
	add	eax, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], eax
	mov	ecx, 1
	shl	ecx, 3
	mov	edx, DWORD PTR _buf$[ebp]
	movzx	eax, BYTE PTR [edx+ecx]
	add	eax, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], eax
	mov	ecx, DWORD PTR _sum2$[ebp]
	add	ecx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], ecx
	mov	edx, 1
	imul	eax, edx, 9
	mov	ecx, DWORD PTR _buf$[ebp]
	movzx	edx, BYTE PTR [ecx+eax]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], edx
	mov	eax, DWORD PTR _sum2$[ebp]
	add	eax, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], eax
	mov	ecx, 1
	imul	edx, ecx, 10
	mov	eax, DWORD PTR _buf$[ebp]
	movzx	ecx, BYTE PTR [eax+edx]
	add	ecx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], ecx
	mov	edx, DWORD PTR _sum2$[ebp]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], edx
	mov	eax, 1
	imul	ecx, eax, 11
	mov	edx, DWORD PTR _buf$[ebp]
	movzx	eax, BYTE PTR [edx+ecx]
	add	eax, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], eax
	mov	ecx, DWORD PTR _sum2$[ebp]
	add	ecx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], ecx
	mov	edx, 1
	imul	eax, edx, 12
	mov	ecx, DWORD PTR _buf$[ebp]
	movzx	edx, BYTE PTR [ecx+eax]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], edx
	mov	eax, DWORD PTR _sum2$[ebp]
	add	eax, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], eax
	mov	ecx, 1
	imul	edx, ecx, 13
	mov	eax, DWORD PTR _buf$[ebp]
	movzx	ecx, BYTE PTR [eax+edx]
	add	ecx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], ecx
	mov	edx, DWORD PTR _sum2$[ebp]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], edx
	mov	eax, 1
	imul	ecx, eax, 14
	mov	edx, DWORD PTR _buf$[ebp]
	movzx	eax, BYTE PTR [edx+ecx]
	add	eax, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], eax
	mov	ecx, DWORD PTR _sum2$[ebp]
	add	ecx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], ecx
	mov	edx, 1
	imul	eax, edx, 15
	mov	ecx, DWORD PTR _buf$[ebp]
	movzx	edx, BYTE PTR [ecx+eax]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], edx
	mov	eax, DWORD PTR _sum2$[ebp]
	add	eax, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], eax

; 119  :             buf += 16;

	mov	ecx, DWORD PTR _buf$[ebp]
	add	ecx, 16					; 00000010H
	mov	DWORD PTR _buf$[ebp], ecx

; 120  :         }

	jmp	$LN9@adler32_z
$LN11@adler32_z:

; 121  :         while (len--) {

	mov	edx, DWORD PTR _len$[ebp]
	mov	DWORD PTR tv298[ebp], edx
	mov	eax, DWORD PTR _len$[ebp]
	sub	eax, 1
	mov	DWORD PTR _len$[ebp], eax
	cmp	DWORD PTR tv298[ebp], 0
	je	SHORT $LN12@adler32_z

; 122  :             adler += *buf++;

	mov	ecx, DWORD PTR _buf$[ebp]
	movzx	edx, BYTE PTR [ecx]
	add	edx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _adler$[ebp], edx
	mov	eax, DWORD PTR _buf$[ebp]
	add	eax, 1
	mov	DWORD PTR _buf$[ebp], eax

; 123  :             sum2 += adler;

	mov	ecx, DWORD PTR _sum2$[ebp]
	add	ecx, DWORD PTR _adler$[ebp]
	mov	DWORD PTR _sum2$[ebp], ecx

; 124  :         }

	jmp	SHORT $LN11@adler32_z
$LN12@adler32_z:

; 125  :         MOD(adler);

	mov	eax, DWORD PTR _adler$[ebp]
	xor	edx, edx
	mov	ecx, 65521				; 0000fff1H
	div	ecx
	mov	DWORD PTR _adler$[ebp], edx

; 126  :         MOD(sum2);

	mov	eax, DWORD PTR _sum2$[ebp]
	xor	edx, edx
	mov	ecx, 65521				; 0000fff1H
	div	ecx
	mov	DWORD PTR _sum2$[ebp], edx
$LN19@adler32_z:

; 127  :     }
; 128  : 
; 129  :     /* return recombined sums */
; 130  :     return adler | (sum2 << 16);

	mov	eax, DWORD PTR _sum2$[ebp]
	shl	eax, 16					; 00000010H
	or	eax, DWORD PTR _adler$[ebp]
$LN1@adler32_z:

; 131  : }

	mov	esp, ebp
	pop	ebp
	ret	12					; 0000000cH
_adler32_z@12 ENDP
_TEXT	ENDS
; Function compile flags: /Odtp
; File c:\cpython\externals\zlib-1.2.11\adler32.c
_TEXT	SEGMENT
_adler$ = 8						; size = 4
_buf$ = 12						; size = 4
_len$ = 16						; size = 4
_adler32@12 PROC

; 138  : {

	push	ebp
	mov	ebp, esp

; 139  :     return adler32_z(adler, buf, len);

	mov	eax, DWORD PTR _len$[ebp]
	push	eax
	mov	ecx, DWORD PTR _buf$[ebp]
	push	ecx
	mov	edx, DWORD PTR _adler$[ebp]
	push	edx
	call	_adler32_z@12

; 140  : }

	pop	ebp
	ret	12					; 0000000cH
_adler32@12 ENDP
_TEXT	ENDS
END
