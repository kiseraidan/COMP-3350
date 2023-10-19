INCLUDE Irvine32.inc

.386
; .model flat, stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
MyString BYTE "Summer is pleasant in Auburn", 0
searchChar BYTE 'r'
foundMessage BYTE "Character found: ", 0
notFoundMessage BYTE "Character not found.", 0
newline BYTE 10, 13, 0

.code
main PROC
    mov esi, OFFSET MyString   ; Address of the string
    mov al, searchChar         ; Character to search for

    mov ecx, 0                ; Initialize index to 0
    xor al, al                ; Initialize the flag (0 = not found, 1 = found)

search_loop:
    mov bl, [esi]             ; Load a character from the string
    cmp bl, 0                ; Check for the null terminator
    je not_found

    cmp bl, al               ; Compare with the character in AL
    je character_found       ; If they match, jump to character_found

    inc esi                  ; Move to the next character
    inc ecx                  ; Increment the index
    jmp search_loop

character_found:
    mov al, 1                 ; Set the flag to indicate character found
    jmp print_result

not_found:
    mov al, 0                 ; Set the flag to indicate character not found

print_result:
    mov esi, OFFSET MyString  ; Reset ESI to the beginning of the string
    add esi, ecx              ; Move ESI to the position of the found character

    mov edx, OFFSET newline   ; Newline before the result
    call WriteString

    cmp al, 1
    je character_found_msg
    jmp not_found_msg

character_found_msg:
    mov edx, OFFSET foundMessage
    call WriteString

    mov al, searchChar         ; Get the character to print its value
    call WriteChar

    mov edx, ecx               ; Get the index
    call WriteDec              ; Print the index as a decimal

    jmp exit_program

not_found_msg:
    mov edx, OFFSET notFoundMessage
    call WriteString

exit_program:
    call Crlf
    exit

main ENDP
END main