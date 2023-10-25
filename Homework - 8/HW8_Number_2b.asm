INCLUDE Irvine32.inc

.386
; .model flat, stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	value DWORD 0A73CD3E9h
	dhVal BYTE 0
	dlVal BYTE 0

.code
main PROC
	mov eax, value
	shr eax, 16
	and eax, 0FFh
	mov dhVal, al

	mov eax, value
	shr eax, 8
	and eax, 0FFh
	mov dlVal, al

	movzx eax, dhVal
	call WriteHex
	call Crlf

	movzx eax, dlVal
	call WriteHex
	call Crlf

	exit
main ENDP

END main