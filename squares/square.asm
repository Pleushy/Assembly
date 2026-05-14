section .data
	char db '#'
	endl db 10
	size db 5

section .text
	global _start

_start:
	xor rax,rax
	xor rcx,rcx

	.loop1:
	add rcx,1
	mov rsi,char
	call _print

	cmp rcx,[size]
	jne .loop1
	
	xor rcx,rcx
	add rax,1
	mov rsi,endl
	call _print

	cmp rax,[size]
	jne .loop1

	call _exit

_exit:
	mov rax,60
	xor rdi,rdi
	syscall

_print:
	push rcx
	push rax
	mov rax,1
	mov rdx,1
	xor rdi,rdi
	syscall
	pop rax
	pop rcx
	ret
