bits	64
;		ShakerSort
section	.data
n:
	dd	5
m:
	dd	3
matrix:
	dd	26, 25, 5
	dd	23, 22, 4
	dd	20, 19, 3
	dd	2147483647, 2147483647, 2147483647
	dd	14, 13, 1
min:
	dd	2147483647, 2147483647, 2147483647, 2147483647, 2147483647	
section	.text
global	_start
_start:							
	mov		ecx, [n]
	cmp		ecx, 1
	jle		exit
	xor		ecx, ecx
m1:	;ищет макс эелемент в строке
	cmp		ecx, [n]
	jge		m4

	mov		eax, 1
	mov		edx, ecx
	sal		edx, 2
	imul	edx
	mov		edx, [m]
	imul	edx
	mov		ebx, matrix
	add		ebx, eax

	xor		edi, edi
	mov		eax, [rbx]
m2: ;
	inc		edi
	cmp		edi, [m]
	jge		m3
	cmp		eax, [rbx+rdi*4]
	cmovg	eax, [rbx+rdi*4]
	jmp		m2
m3:	
	mov		[min+rcx*4], eax
	inc		ecx
	jmp		m1				
m4:
	mov		ecx, [n]
	dec		ecx
	xor		edx, edx
	xor		edi, edi
	mov		ebx, min

	mov		eax, [min+edi*4]
m5:
	cmp		edi, ecx
	jge		m6

	cmp		eax, [min+edi*4+4]
	jle		m53
m51:
	mov		r8d, [min+edi*4+4]
	mov		[min+edi*4], r8d
	mov		[min+edi*4+4], eax
	jmp		right
m52:
	inc		edi
	jmp		m5
m53:
	mov		eax, [min+edi*4+4]
	inc		edi
	jmp		m5
m6:
	mov		eax, [min+edi*4]
m7:
	cmp		edi, edx
	jle		m8

	cmp		eax, [min+edi*4-4]
	jge		m73
m71:
	mov		r9d, [min+edi*4-4]
	mov		[min+edi*4], r9d
	mov		[min+edi*4-4], eax
	jmp		left
m72:
	dec		edi
	jmp		m7
m73:
	mov		eax, [min+edi*4-4]
	dec		edi
	jmp		m7
m8:
	dec		ecx
	inc		edx

	cmp		ecx, edx
	jle		exit

	jmp		m5
right:
	xor		esi, esi
	mov		r10d, [m]
	xor		r12d, r12d
	xor		r13d, r13d

	mov		r11d, [m]
	sal		r11d, 2

	add		r13d, r11d

	imul	r11d, edi
	add		r12d, r11d
	add		r13d, r11d
r1:
	cmp		esi, r10d
	jge		m52
	
	mov		r14d, [matrix+r12d]
	mov		r15d, [matrix+r13d]
	mov		[matrix+r13d], r14d
	mov		[matrix+r12d], r15d 	

	add		r12d, 4
	add		r13d, 4
	inc		esi
	jmp		r1		
left:
	xor		esi, esi
	mov		r10d, [m]
	xor		r12d, r12d
	xor		r13d, r13d

	mov		r11d, [m]
	sal		r11d, 2

	sub		r12d, r11d

	imul	r11d, edi
	add		r12d, r11d
	add		r13d, r11d
l1:
	cmp		esi, r10d
	jge		m72
	
	mov		r14d, [matrix+r12d]
	mov		r15d, [matrix+r13d]
	mov		[matrix+r13d], r14d
	mov		[matrix+r12d], r15d 	

	add		r12d, 4
	add		r13d, 4
	inc		esi
	jmp		l1
exit:
	mov		eax, 60
	mov		edi, 0
	syscall
