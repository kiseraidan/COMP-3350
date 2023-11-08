INCLUDE Irvine32.inc

.386
; .model flat, stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	iteration BYTE "Iteration count: ", 0
	first BYTE "The first packed BCD number: ", 0
	second BYTE "The second packed BCD number: ", 0
	result BYTE "The result of the subtraction is: ", 0
	test_data QWORD 0999999999h, 1h, 123456789h, 100h, 10h

.code
main PROC
	mov ecx, 3
	mov esi, 0

	l1:
		mov edx, OFFSET iteration
		call WriteString
		mov eax, 4
		sub eax, ecx
		call WriteDec
		call Crlf

		mov edx, OFFSET first
		call WriteString
		mov eax, DWORD ptr test_data[esi + 4]
		call WriteHex
		mov eax, DWORD ptr test_data[esi]
		call WriteHex
		call Crlf
		mov ebx, DWORD ptr test_data[esi]
		mov edx, 0
		mov dl, BYTE ptr test_data[esi + 4]
		push edx

		add esi, 8
		mov edx, OFFSET second
		call WriteString
		mov eax, DWORD ptr test_data[esi + 4]
		call WriteHex
		mov eax, DWORD ptr test_data[esi]
		call WriteHex
		call Crlf
		mov eax, DWORD ptr test_data[esi]
		pop edx
		mov dh, BYTE ptr test_data[esi + 4]

		push ecx
		mov ecx, 4

		l2:
			stc
			cmp ecx, 1
			je adjust
			sub al, bl
			das
			ror eax, 8
			ror ebx, 8
		loop l2

		adjust:
			sub al, bl
			das
			ror eax, 8
			ror ebx, 8

			pop ecx
			mov edi, eax
			movzx eax, dh
			sbb al, dl
			das

			push edx
			mov edx, OFFSET result
			call WriteString
			call WriteHex
			mov eax, edi
			call WriteHex
			call Crlf
			call Crlf
			pop edx

			add esi, 8
		dec cx
		jne l1
		exit
main ENDP

END main