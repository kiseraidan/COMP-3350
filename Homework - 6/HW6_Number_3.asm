.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode: DWORD

INCLUDE Irvine32.inc

.model small
.data
prompt      BYTE "Please input a value: ", 0
spacing     BYTE ", ", 0
String1     BYTE "The target value is ", 0
String2     BYTE "and is located at index: ", 0
String3     BYTE "Value not found", 0

.stack 100h

.code
start:
    ; Initialize the stack with negative values
    mov cx, 6       ; Number of values in the stack
    mov si, 0       ; Initialize index to 0
    mov bx, -5      ; Initialize the first value

initialize_stack:
    push bx
    add si, 1
    inc bx
    loop initialize_stack

    ; Prompt for the target value
    mov ah, 09h
    lea dx, prompt
    int 21h

    ; Read the target value from the user
    mov ah, 0ah
    lea dx, target_value
    int 21h

    ; Convert the target value to an integer
    mov ax, target_value
    sub ax, 48

    ; Call the Search procedure
    call Search

    ; Check the result from the Search procedure
    cmp ax, -1
    je not_found
    jge found

not_found:
    ; Print "Value not found"
    mov ah, 09h
    lea dx, String3
    int 21h
    jmp exit

found:
    ; Print "The target value is " and the value in AX
    mov ah, 09h
    lea dx, String1
    int 21h

    mov ax, target_value
    add ax, 48
    mov dl, al
    mov ah, 02h
    int 21h

    ; Print ", and is located at index: " and the index in AX
    mov ah, 09h
    lea dx, spacing
    int 21h

    mov ah, 09h
    lea dx, String2
    int 21h

    mov ax, index
    add ax, 48
    mov dl, al
    mov ah, 02h
    int 21h

exit:
    ; Terminate the program
    mov ah, 4Ch
    int 21h

Search PROC
    push bp
    mov bp, sp

    ; Load AX with the target value
    mov ax, [bp + 4]

    ; Initialize index to -1
    mov di, -1

    ; Initialize SI to 0
    mov si, 0

search_loop:
    ; Check if the stack is empty
    cmp si, cx
    jge not_found

    ; Compare the value on the stack with the target value
    mov bx, [bp + 6 + si * 2]
    cmp ax, bx

    ; If they match, store the index in DI and break the loop
    je found

    ; Increment the index and continue searching
    inc si
    jmp search_loop

found:
    mov di, si

not_found:
    ; Store the result in AX and return
    mov ax, di
    pop bp
    ret

Search ENDP

target_value db 0
index db 0

END start