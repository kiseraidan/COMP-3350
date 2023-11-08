INCLUDE Irvine32.inc

.386
; .model flat, stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	intro BYTE "This program computes X = A + B - C", 0
	A_prompt BYTE "Please enter a value for A: ", 0
	B_prompt BYTE "Please enter a value for B: ", 0
	C_prompt BYTE "Please enter a value for C: ", 0
	result BYTE "The value of X is: ", 0

.code
main PROC
	mov edx, OFFSET intro
	call WriteString
	call Crlf

	mov edx, OFFSET A_prompt
	call WriteString
	call ReadInt
	push eax

	mov edx, OFFSET B_prompt
	call WriteString
	call ReadInt
	push eax

	mov edx, OFFSET C_prompt
	call WriteString
	call ReadInt
	push eax

	mov ebx, 10

	call Arithmetic_Expression

	mov eax, [esi]
	mov edx, OFFSET result
	call WriteString
	call WriteInt
	call Crlf

	exit
main ENDP

Arithmetic_Expression PROC
	pop ebx
	pop edx
	pop eax

	sub eax, edx
	pop edx
	add eax, edx
	push eax

	mov esi, esp
	push ebx

	ret
Arithmetic_Expression ENDP

END main