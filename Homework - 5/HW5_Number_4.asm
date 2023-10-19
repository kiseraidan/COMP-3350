INCLUDE Irvine32.inc

.data
	MySignedArray SWORD -1, 78, 0ACh, 4567, -7, -273, 92
	msg1   BYTE "Enter the value of n: ",0
	msg2   BYTE "First n odd numbers in array: ",0
	n      WORD ?

.code
main PROC
	mov edx, OFFSET msg1           ; Print "Enter the value of n: "
	call WriteString
	call ReadInt                  ; Read a number into n
	mov n, ax

	cmp n, 0                      ; If n <= 0, then exit
	jle L2

	mov edx, OFFSET msg2           ; Print "First n odd numbers in array: "
	call WriteString
	mov esi, OFFSET MySignedArray  ; esi = address of MySignedArray
	mov ecx, LENGTHOF MySignedArray ; ecx = number of elements
	mov bx, 0                      ; Used for count

L3:
	mov ax, [esi]                 ; ax = MySignedArray[i]
	test ax, 1                    ; Test if ax is odd
	jz L1                         ; If even, skip to L1
	cwde                          ; eax = extended word in ax
	call WriteInt                 ; Print MySignedArray[i]
	inc bx                         ; Increment count
	cmp bx, n                     ; If count == n, exit the loop
	je L2

L1:
	add esi, 2                    ; Move to the next element
	loop L3                        ; Repeat until ecx != 0

L2:
	call crlf
	call WaitMsg                  ; Print a wait message
	exit

main ENDP
END main