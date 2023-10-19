TITLE Addressing Modes              (main.asm)

INCLUDE Irvine32.inc
.data
   alpha       DWORD       0A1B1C1D1h, 87654321h  
   beta        DWORD       67EED9FCh, 21A220C2h
   gamma       DWORD       0BCB1D44Fh
.code       

main PROC   
      mov eax, 1C2Fh;         Immediate
      mov ecx, eax;           Register to Register    
      mov edi, OFFSET beta;   Immediate   
      mov [gamma], eax;       Direct      
      mov esi, gamma;         Direct      
      mov esi, 4;             Immediate   
      mov eax, beta[esi];     Indirect-offset   
      mov ebx, OFFSET alpha;  Immediate   
      mov eax, 4[ebx];        Indirect-displacement  
      mov eax, [ebx];         Indirect    
      mov eax,4[ebx][esi]; Base-Indirect-displacement
exit
main ENDP
END main