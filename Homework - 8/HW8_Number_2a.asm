INCLUDE Irvine32.inc

.386
; .model flat, stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	multiplier DWORD 1510

.code
main PROC
	mov ebx, 5
	mov ecx, multiplier

	xor eax, eax
	xor edx, edx

multiply_loop:
	test ecx, ecx
	jz done

	test ecx, 1
	jz skip_multiply

	add eax, ebx

skip_multiply:
	shl ebx, 1
	shr ecx, 1
	jmp multiply_loop

done:
	; The result is now in EAX

	call DumpRegs
	exit

main ENDP

END Main