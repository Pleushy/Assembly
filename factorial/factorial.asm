section .data
	
section .text
	global factorial

factorial:
	; rax = output
	; rdi = input

	mov rax,1
	test rdi,rdi
	jz .done

	.loop:
	imul rdi
	dec rdi

	test rdi,rdi
	jnz .loop

	.done:
	ret
