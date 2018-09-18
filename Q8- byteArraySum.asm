; OBJECTIVE :    To add all the elements of a byte array.
; APPROACH  :    Use the LOOP instruction to add the elements.

; Data segment begins.
DATA SEGMENT
    
    ; Variable initialization.
    myArray DB  01H, 02H, 03H, 04H, 05H
    size    DB  5
    sum     DB  ?
    
; Data segment ends.
DATA ENDS

; Code segment begins.
CODE SEGMENT
    
    ; Bind the registers with the segments.
    ASSUME  :   DS:DATA CS:CODE
    
    START:
    
    ; Move the address of the DATA segment to DS register.
    MOV AX  ,   DATA
    MOV DS  ,   AX
    
    ; Set the register values.
    XOR AX  ,   AX
    MOV CL  ,   size
    MOV SI  ,   0
    
    ; Add the elements.
    REPEAT:
        ADD AL  ,   myArray[SI]
        INC SI
    LOOP REPEAT
    
    MOV sum ,   AL
    
; Code segment ends.
CODE ENDS

; START ends.
END START
