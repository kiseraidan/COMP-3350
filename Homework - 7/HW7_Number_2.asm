INCLUDE Irvine32.inc

.386
; .model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
    plaintext BYTE "Kiser", 0
    key BYTE 37  ; Replace with the last two or three digits of your student ID
    ciphertext BYTE 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    decrypted BYTE 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.code
main PROC
    ; Calculate the length of the string
    mov esi, OFFSET plaintext
    xor ecx, ecx
count_length:
    mov al, [esi + ecx]
    cmp al, 0
    je encoding
    inc ecx
    jmp count_length

encoding:
    ; XOR encode the plaintext
    mov esi, OFFSET plaintext
    mov edi, OFFSET ciphertext
    mov bl, key  ; Replace with the last two or three digits of your student ID
encode_loop:
    mov al, [esi]
    xor al, bl
    mov [edi], al
    inc esi
    inc edi
    loop encode_loop

    ; Display the plaintext and ciphertext
    mov edx, OFFSET plaintext
    call WriteString
    mov edx, OFFSET ciphertext
    call WriteString

    ; XOR decode the ciphertext
    mov esi, OFFSET ciphertext
    mov edi, OFFSET decrypted
decode_loop:
    mov al, [esi]
    xor al, bl
    mov [edi], al
    inc esi
    inc edi
    loop decode_loop

    ; Display the decrypted text
    mov edx, OFFSET decrypted
    call WriteString

    exit
main ENDP
END main