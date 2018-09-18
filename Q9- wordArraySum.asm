; OBJECTIVE :    To find the sum of all the elements of a word array.
; APPROACH  :    Use LOOP instruction to add the elements.

; Data segment begins.
DATA SEGMENT  
     
    ; Variable initialization.
    myArray  DW  12A1H, 5102H, 1119H, 3211H, 3118H
    size     DW  5
    sum      DW  ?
       
; Data segment ends.
DATA ENDS

; Code segment begins.
CODE SEGMENT
    
    ; Bind the segments with the corresponding registers.
    ASSUME  :   DS:DATA CS:CODE  
    
    START:
    
    ; Move the address of DATA segment to DS register.
    MOV AX  ,   DATA
    MOV DS  ,   AX
    
    ; Set the registers.
    XOR AX  ,   AX
    MOV CX  ,   size
    MOV SI  ,   0
    
    ; Add the elements.
    REPEAT:
        ADD AX  ,   myArray[SI]
        ADD SI  ,   2
    LOOP REPEAT
    
    MOV sum ,   AX

; Code segment ends.
CODE ENDS

; Start ends.
END START
