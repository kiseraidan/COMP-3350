.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode: DWORD

INCLUDE Irvine32.inc

.data
inputPrompt BYTE "Enter 0 for Blue, 1 for Yellow, or 2 for Red: ", 0
tigerStr BYTE "War Eagle", 0

; Define color constants for your code
myBlue EQU 1
myYellow EQU 2
myRed EQU 3

.code
InputIntColor PROC
    ; Display the input prompt
    mov edx, OFFSET inputPrompt
    call WriteString

    ; Read an integer from the keyboard
    call ReadInt

    ; Check the value and set BL accordingly
    cmp eax, 0
    je SetBlueColor
    cmp eax, 1
    je SetYellowColor
    cmp eax, 2
    je SetRedColor
    jmp InvalidInput

SetBlueColor:
    mov bl, myBlue
    ret

SetYellowColor:
    mov bl, myYellow
    ret

SetRedColor:
    mov bl, myRed
    ret

InvalidInput:
    ; Handle invalid input (not 0, 1, or 2)
    mov bl, 0xFF
    ret

InputIntColor ENDP

DisplayTiger PROC
    ; Check the value of BL and set the text color accordingly
    cmp bl, myBlue
    je BlueColor
    cmp bl, myYellow
    je YellowColor
    cmp bl, myRed
    je RedColor
    jmp DefaultColor

BlueColor:
    mov eax, blue
    call SetTextColor
    jmp PrintString

YellowColor:
    mov eax, yellow
    call SetTextColor
    jmp PrintString

RedColor:
    mov eax, red
    call SetTextColor
    jmp PrintString

DefaultColor:
    ; Set default text color
    call DefaultColor
    jmp PrintString

PrintString:
    mov edx, OFFSET tigerStr
    call WriteString
    ret

main PROC
    ; Call InputIntColor to get the color choice
    call InputIntColor

    ; Call DisplayTiger to display "War Eagle" in the chosen color
    call DisplayTiger

    ; Exit the program
    call ExitProcess

main ENDP

DisplayTiger ENDP

END main