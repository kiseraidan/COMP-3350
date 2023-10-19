INCLUDE Irvine32.inc

.data
CloudArray SWORD 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
MistArray SWORD 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
FogArray SWORD 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.code
main PROC
    mov esi, OFFSET CloudArray   ; Point ESI to CloudArray
    mov ecx, LENGTHOF CloudArray ; Set loop counter to the number of elements in CloudArray

    ; Display CloudArray
DisplayCloudArray:
    mov ax, [esi]   ; Load an element from CloudArray into AX
    call WriteInt   ; Display the element
    call Crlf       ; Newline
    add esi, TYPE CloudArray   ; Move to the next element
    loop DisplayCloudArray     ; Loop until all elements are displayed

    mov esi, OFFSET MistArray   ; Point ESI to MistArray

    ; Display MistArray
DisplayMistArray:
    mov ax, [esi]   ; Load an element from MistArray into AX
    call WriteInt   ; Display the element
    call Crlf       ; Newline
    add esi, TYPE MistArray    ; Move to the next element
    loop DisplayMistArray      ; Loop until all elements are displayed

    mov esi, OFFSET CloudArray  ; Reset ESI to the beginning of CloudArray
    mov edi, OFFSET MistArray   ; Point EDI to MistArray
    mov ebx, OFFSET FogArray    ; Point EBX to FogArray

    ; Sum CloudArray and MistArray, store in FogArray
SumArrays:
    mov ax, [esi]   ; Load an element from CloudArray into AX
    add ax, [edi]   ; Add the corresponding element from MistArray
    mov [ebx], ax   ; Store the result in FogArray
    add esi, TYPE CloudArray  ; Move to the next element in CloudArray
    add edi, TYPE MistArray   ; Move to the next element in MistArray
    add ebx, TYPE FogArray    ; Move to the next element in FogArray
    loop SumArrays  ; Loop until all elements are summed

    mov esi, OFFSET FogArray    ; Point ESI to FogArray

    ; Display FogArray
DisplayFogArray:
    mov ax, [esi]   ; Load an element from FogArray into AX
    call WriteInt   ; Display the element
    call Crlf       ; Newline
    add esi, TYPE FogArray      ; Move to the next element
    loop DisplayFogArray        ; Loop until all elements are displayed

    exit
main ENDP

END main