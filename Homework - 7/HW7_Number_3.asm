INCLUDE Irvine32.inc

.386
; .model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
    sensor1     DWORD 55  ; Change this value for the first sensor
    sensor2     DWORD 52  ; Change this value for the second sensor
    diff_limit  DWORD 4   ; Maximum allowed difference

    agree_msg   BYTE "Agree", 0
    disagree_msg BYTE "Disagree", 0
    nose_down_msg BYTE "Nose Down", 0

.code
main PROC
    mov     eax, sensor1
    sub     eax, sensor2
    cdq                     ; Sign-extend EAX into EDX
    imul    edx, edx, -1     ; Absolute difference
    cmp     edx, diff_limit  ; Compare with the difference limit
    jle     check_sensor_values

    ; Values differ by more than 4
    mov     edx, OFFSET disagree_msg
    call    WriteString
    jmp     exit_program

check_sensor_values:
    ; Both sensors agree
    cmp     sensor1, 50
    jl      print_agree
    cmp     sensor2, 50
    jl      print_agree

    ; Both sensors are greater than 50
    mov     edx, OFFSET nose_down_msg
    call    WriteString
    jmp     exit_program

print_agree:
    mov     edx, OFFSET agree_msg
    call    WriteString

exit_program:
    call    Crlf
    exit
main ENDP
END main