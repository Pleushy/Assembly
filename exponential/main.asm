section .data
	
section .text
	global uint64_pow

uint64_pow:
	; rax = output
	; rdi = input1
	; rsi = input2

	mov rax,1
	test rsi,rsi
	jz .done

	.loop:
	imul rdi
	dec rsi

	test rsi,rsi
	jnz .loop

	.done:
	ret
