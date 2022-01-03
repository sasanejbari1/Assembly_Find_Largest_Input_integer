	; System calls
SYS_WRITE		equ		1
; File descriptors
FD_STDOUT		equ		1

; External symbols
extern libPuhfessorP_printSignedInteger64
extern output_array
extern input_array
extern find_largest

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Begin the data section
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section	.data
; Strings
msg1 		db 	"This manager is here to assist you.", 13, 10, 13, 10
msg1_len	equ	$-msg1
msg2 		db 	"The following integers were received: ", 13, 10, "("
msg2_len	equ	$-msg2
msg3 		db 	" integers) "
msg3_len	equ	$-msg3
msg4 		db 	"Error! No integers were entered, so no largest exists.", 13, 10
msg4_len	equ	$-msg4
msg5 		db 	"The largest value "
msg5_len	equ	$-msg5
msg6 		db 	" has been found at index "
msg6_len	equ	$-msg6
msg7 		db 	13, 10, "The manager will now return the count to the driver.", 13, 10, 13, 10
msg7_len	equ	$-msg7
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Begin the text section
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section	.text

global manager
manager:
	; Save registers
	push rbx
	push rbp
	push r12
	push r13
	
	; Save current value of rsp register
	mov rbp, rsp
	
	; Allocate space in stack for an array of 100 long intergers
	sub rsp, 800
	mov r12, rsp				; Keep a pointer to the first integer we've created
	
	; Print out the welcome message
	mov rax, SYS_WRITE			; System call code goes into rax
	mov rdi, FD_STDOUT			; Tell the system to print to STDOUT
	mov rsi, msg1				; Provide the memory location to start reading our characters to print
	mov rdx, msg1_len			; Provide the number of characters print
	syscall
	
	; Call C++ function input_array to initialize the given array with the user provided integers
	mov rdi, r12				; First parameter is the array's address
	mov rsi, 100				; Second parameter is the max size
	call input_array
	mov rbx, rax				; Store the count of numbers provided by the user 
	cmp rbx, 0
	ja print_array
	
	; Print out the error message
	mov rax, SYS_WRITE			; System call code goes into rax
	mov rdi, FD_STDOUT			; Tell the system to print to STDOUT
	mov rsi, msg4				; Provide the memory location to start reading our characters to print
	mov rdx, msg4_len			; Provide the number of characters print
	syscall
	jmp return_back
	
print_array:	
	; Print out the msg2 message
	mov rax, SYS_WRITE			; System call code goes into rax
	mov rdi, FD_STDOUT			; Tell the system to print to STDOUT
	mov rsi, msg2				; Provide the memory location to start reading our characters to print
	mov rdx, msg2_len			; Provide the number of characters print
	syscall
	; Print out the count
	mov rdi, rbx
	call libPuhfessorP_printSignedInteger64
	; Print out the msg3 message
	mov rax, SYS_WRITE			; System call code goes into rax
	mov rdi, FD_STDOUT			; Tell the system to print to STDOUT
	mov rsi, msg3				; Provide the memory location to start reading our characters to print
	mov rdx, msg3_len			; Provide the number of characters print
	syscall
	
	; Call assembly procedure output_array and ask it to print out the comma separated numbers
	mov rdi, r12				; First parameter is the array's address
	mov rsi, rbx				; Second parameter is the total numbers to be printed
	call output_array
	
	; Call assembly procedure find_largest to fidn out the index of largest number in the array
	mov rdi, r12				; First parameter is the array's address
	mov rsi, rbx				; Second parameter is the total numbers to be printed
	call find_largest
	mov r13, rax				; Save the returned index
	
	; Print out the msg5 message
	mov rax, SYS_WRITE			; System call code goes into rax
	mov rdi, FD_STDOUT			; Tell the system to print to STDOUT
	mov rsi, msg5				; Provide the memory location to start reading our characters to print
	mov rdx, msg5_len			; Provide the number of characters print
	syscall
	; Print out the value
	mov rsi, r13
	shl rsi, 3
	add rsi, r12
	mov rdi, [rsi]				; Get the value at the returned index
	call libPuhfessorP_printSignedInteger64
	; Print out the msg6 message
	mov rax, SYS_WRITE			; System call code goes into rax
	mov rdi, FD_STDOUT			; Tell the system to print to STDOUT
	mov rsi, msg6				; Provide the memory location to start reading our characters to print
	mov rdx, msg6_len			; Provide the number of characters print
	syscall
	; Print out the index
	mov rdi, r13				
	call libPuhfessorP_printSignedInteger64
	
return_back:
	; Print out the msg7 message
	mov rax, SYS_WRITE			; System call code goes into rax
	mov rdi, FD_STDOUT			; Tell the system to print to STDOUT
	mov rsi, msg7				; Provide the memory location to start reading our characters to print
	mov rdx, msg7_len			; Provide the number of characters print
	syscall		
	; Return
	mov rax, rbx				; Set return value to the count 
	mov rsp, rbp				; Free up the space that was reserved in stack for input array
	pop r13
	pop r12
	pop rbp
	pop rbx
	ret
