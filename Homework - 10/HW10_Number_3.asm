; Counts the characters in any string.

INCLUDE Irvine32.inc

.386
; .model flat, stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	prompt BYTE "String to count: ",0
	answer BYTE "There are ",0
	answer_fin BYTE " characters in the string",0
	test_1 BYTE 0
	test_2 BYTE "This is test string one",0
	test_3 BYTE "This is test string two hello hello",0
	test_4 BYTE "This is test string three what up what up yall",0

.code
main PROC
	mov edx, OFFSET prompt
	call WriteString
	mov edx, OFFSET test_1
	call WriteString
	call crlf
	mov edx, OFFSET answer
	call WriteString
	mov eax, 0
	call WriteDec
	mov edx, OFFSET answer_fin
	call WriteString
	call crlf
	call crlf

	mov edx, OFFSET prompt
	call WriteString
	mov edx, OFFSET test_2
	call WriteString 
	call crlf
	mov edx, OFFSET answer
	call WriteString
	mov eax, lengthof test_2
	sub eax, 1
	call WriteDec
	mov edx, OFFSET answer_fin
	call WriteString
	call crlf
	call crlf

	mov edx, OFFSET prompt
	call WriteString
	mov edx, OFFSET test_3
	call WriteString
	call crlf
	mov edx, OFFSET answer
	call WriteString
	mov eax, lengthof test_3
	sub eax, 1
	call WriteDec
	mov edx, OFFSET answer_fin
	call WriteString
	call crlf
	call crlf

	mov edx, OFFSET prompt
	call WriteString
	mov edx, OFFSET test_4
	call WriteString
	call crlf
	mov edx, OFFSET answer
	call WriteString
	mov eax, lengthof test_4
	sub eax, 1
	call WriteDec
	mov edx, OFFSET answer_fin
	call WriteString
	call crlf
	call crlf
	
	exit
main ENDP

END main