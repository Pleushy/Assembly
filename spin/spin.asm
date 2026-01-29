; Code for a spinning dash | / - \ |

section .data
	clear db 13
	delay dq 0, 100000000
	one db '|'
	two db '/'
	three db '-'
	four db '\'

section .text
	global _start

_start:
	mov rdx,1
	mov rsi,one
	call _print
	call _clear
	mov rsi,two
	call _print
	call _clear
	mov rsi,three
	call _print
	call _clear
	mov rsi,four
	call _print
	call _clear

	jmp _start

	.done:
	mov rax,60
	xor rdi,rdi
	syscall

_print:
	push rdx
	mov rax,1
	xor rdi,rdi
	syscall
	pop rdx
	ret

_sleep:
	mov rax,35
	mov rdi,delay
	xor rsi,rsi
	syscall
	ret

_clear:
	call _sleep
	mov rsi,clear
	call _print
	ret
