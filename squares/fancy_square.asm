section .data
	corner db '+'
	hline db '-'
	vline db '|'
	endl db 10
	space db ' '

section .text
	global _start

_start:
	mov rsi,10
	call _draw
	
	call _exit

_exit:
	mov rax,60
	xor rdi,rdi
	syscall

_draw:
	mov rax,rsi
	push rsi
	call _horiz

	pop rsi
	mov rax,rsi
	push rsi
	xor rdx,rdx
	mov rcx,2
	idiv rcx
	mov rcx,rax
	test rcx,rcx
	jnz .l
	add rcx,1
	.l:
	pop rsi
	mov rax,rsi
	push rsi
	call _vert
	sub rcx,1
	test rcx,rcx
	jnz .l

	pop rsi
	mov rax,rsi
	push rsi
	call _horiz
	pop rsi
	ret

_horiz:
	mov rsi,corner
	call _print
	.l:
	sub rax,1
	mov rsi,hline
	call _print
	test rax,rax
	jnz .l
	mov rsi,corner
	call _print
	mov rsi,endl
	call _print
	ret

_vert:
	mov rsi,vline
	call _print
	.l:
	mov rsi,space
	call _print
	sub rax,1
	test rax,rax
	jnz .l
	mov rsi,vline
	call _print
	mov rsi,endl
	call _print
	ret

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
