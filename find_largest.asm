;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Begin the text section
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section	.text

global find_largest

find_largest:
		
	mov rcx, [rdi]				; Get the first number. Assume it to be the largest
	mov rax, 0					; rax will store the index of the largest number
	mov rdx, 0					; loop counter
	; Loop to find out the index of the largest integer
find_loop:
	
	; Increment loop counter
	inc rdx
	
	; Check if we have compared all the numbers
	cmp rdx, rsi				; If yes
	jae end_find_loop			; End the loop						
		
	add rdi, 8					; Move on to the next element	
	cmp rcx, [rdi]				; Check if the current largest is greater than the current array element
	jge dont_update				; If yes, don't update it
	mov rcx, [rdi]				; Else, update the largest number
	mov rax, rdx				; Update the index of the largest number
dont_update:
	; Repeat
	jmp find_loop			
	
end_find_loop:	

	; Return
	ret
