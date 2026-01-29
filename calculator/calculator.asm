; calculator in asm (kinda works?)

section .data
	endl db 10
	q1 db "Input first number: "
	q1L equ $-q1
	q2 db "Input operator: "
	q2L equ $-q2
	q3 db "Input second number: "
	q3L equ $-q3
	err db "Please try again."
	errL equ $-err

section .bss
	op resd 8
	n1 resd 8
	n2 resd 8

section .text
	global _start
_start:
	mov rsi,q1
	mov rdx,q1L
	call _print

	mov rsi,n1
	call _read

	mov rsi,q2
	mov rdx,q2L
	call _print

	mov rsi,op
	call _read

	mov rsi,q3
	mov rdx,q3L
	call _print

	mov rsi,n2
	call _read

	mov rcx,n1
	call _toInteger
	test rax,rax
	jz _error
	mov r8,rax

	mov rcx,n2
	call _toInteger
	test rax,rax
	jz _error
	mov r9,rax

	call _compareOperator

	mov rax,r8
	call _toAscii
	mov rdx,32
	call _print

	mov rsi,endl
	mov rdx,1
	call _print

	mov rax,60
	xor rdi,rdi
	syscall

_compareOperator:
	cmp byte [op],'+'
	je .add
	cmp byte [op],'-'
	je .sub
	cmp byte [op],'*'
	je .mul
	cmp byte [op],'/'
	je .div
	jmp _error

	.add:
	add r8,r9
	jmp .done
	.sub:
	sub r8,r9
	jmp .done
	.mul:
	imul r8,r9
	jmp .done
	.div:
	mov rcx,r9
	xor rdx,rdx
	mov rax,r8
	idiv rcx
	mov r8,rax
	mov r9,rdx
	jmp .done
	.done:
	ret

_print: ;rsi = msg, rdx = len
	mov rax,1
	xor rdi,rdi
	syscall
	ret

_read: ;rsi = register
	xor rax,rax
	xor rdi,rdi
	mov rdx,32
	syscall
	mov byte [rsi-1+rax],0
	ret

_error:
	mov rsi,err
	mov rdx,errL
	call _print
	mov rsi,endl
	mov rdx,1
	call _print
	jmp _start

_toAscii: ;input/output : rax/rsi
	xor rbx,rbx
	mov rcx,10

	.loop:
	xor rdx,rdx
	div rcx
	add rdx,'0'
	push rdx
	inc rbx
	test rax,rax
	jnz .loop

	xor rax,rax
	.reverse:
	pop rdx
	mov [rsi+rax],rdx
	inc rax
	cmp rax,rbx
	jne .reverse

	.done:
	ret


_toInteger: ;input/output : rcx/rax
	mov rbx,10
	xor rax,rax
	.loop:
	movzx rdx, byte [rcx]
	test rdx,rdx
	jz .done

	inc rcx

	cmp rdx,'0'
	jb _error
	cmp rdx,'9'
	ja _error

	sub rdx,'0'
	imul rax,rbx
	add rax,rdx
	jmp .loop
	.done:
	ret
