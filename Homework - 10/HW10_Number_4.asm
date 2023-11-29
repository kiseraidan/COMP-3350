; Displays the z coordinates of an array of 3D points.

INCLUDE Irvine32.inc

.386
; .model flat, stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

coordinate struct
	x WORD ?
	y WORD ?
	z WORD ?
coordinate ENDS

.data
	prompt BYTE "Here are the z coordinates for a list of ten 3D coordinate pairs:",0
	set_of_coordinates coordinate 10 dup(<>)
	example_z_coordinates WORD 6d,7d,0d,4d,3d,9d,1d,8d,5d,2d

.code
main PROC
	mov edx, OFFSET prompt
	call WriteString
	call crlf

	mov ecx, 10
	mov esi, 0
	mov edi, 0

	l1:
		mov bx, example_z_coordinates[edi]
		mov set_of_coordinates[esi].z, bx
		add esi, sizeof coordinate
		add edi, 2
	loop l1

	mov ecx, 10
	mov ebx, OFFSET set_of_coordinates
	mov esi, 4
	mov eax, 0

	l2:
		mov ax, [ebx+esi]
		call WriteDec
		call crlf
		add ebx, sizeof coordinate
	loop l2

	exit
main ENDP

END main