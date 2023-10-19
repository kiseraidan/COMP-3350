.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode: DWORD

INCLUDE Irvine32.inc

.data
PromptUser BYTE "Please enter a value:", 0

.code
main PROC
    mov ecx, 5 ; loop counter

    ; initialize stack
    mov ebp, esp

InputLoop:
    ; prompt user for input
    invoke WriteString, ADDR PromptUser

    ; read input from user
    mov edx, OFFSET PromptUser
    call ReadInt

    ; store input in stack
    push eax

    ; decrement loop counter
    dec ecx
    jnz InputLoop

OutputLoop:
    ; pop value from stack and display on screen
    pop eax
    invoke WriteInt, eax
    invoke WriteString, ADDR newline

    ; decrement loop counter
    dec ecx
    jnz OutputLoop

    ; exit program
    invoke ExitProcess, 0

main ENDP

newline BYTE 13, 10, 0

END main