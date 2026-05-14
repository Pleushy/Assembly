section .data
	text db "Input size (1-9): "
	text_len equ $-text
	err db "Wrong. Try again."
	err_len equ $-err
	char db '#'
	char_len equ $-char
	endl db 10

section .bss
	size resb 1

section .text
	global _start

_start:
	.rl:
	mov rsi,text
	mov rdx,text_len
	call _print
	mov rsi,size
	call _read

	cmp byte [size],'0'
	jle .err
	cmp byte [size],'9'
	jg .err
	jmp .cont

	.err:
	mov rsi,err
	mov rdx,err_len
	call _print
	mov rsi,endl
	mov rdx,1
	call _print
	jmp .rl
	
	.cont:
	sub byte [size],'0'

	xor rax,rax
	xor rcx,rcx

	.loop1:
	add rcx,1
	mov rdx,char_len
	mov rsi,char
	call _print

	cmp rcx,[size]
	jne .loop1
	
	xor rcx,rcx
	add rax,1
	mov rdx,1
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
	xor rdi,rdi
	syscall
	pop rax
	pop rcx
	ret

_read:
	xor rax,rax
	xor rdi,rdi
	mov rdx,2
	syscall
	mov byte [rsi-1+rax],0
	ret
