; OBJECTIVE :    To add all the elements of a doubleword array.
; APPROACH  :    Use the LOOP instruction to add the elements.

; Data segment begins.
DATA SEGMENT
    
    ; Variable initialization.
    myArray DD  4283A011H, 2391023AH, 32192002H, 10102212H, 1555F821H
    size    DW  5
    sum     DD  ?
    
; Data segment ends.
DATA ENDS

; Code segment begins
CODE SEGMENT
    
    ; Bind the segments with the corresponding registers.
    ASSUME  :   DS:DATA CS:CODE 
    
    START:
    
    ; Move the address of the DATA segment to DS register.
    MOV AX  ,   DATA
    MOV DS  ,   AX
    
    ; Set the registers.
    XOR AX  ,   AX
    MOV CX  ,   size 
    MOV SI  ,   0
    
    ; Add the elements.
    REPEAT:
        ADD AX  ,   WORD PTR myArray[SI]
        ADC DX  ,   WORD PTR myArray[SI+2]
        ADD SI  ,   4
    LOOP REPEAT
    
    MOV sum     ,   AX
    MOV sum+2   ,   DX   
    
; Code segment ends.
CODE ENDS

; START ends.
END START
