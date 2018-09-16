; OBJECTIVE :   To evaluate the expression X+Y+24H-Z,
;               where X, Y and Z are double word variables.
; APPROACH  :   Perform byte-by-byte binary addition and subtraction operations.

; Data segment begins.
DATA SEGMENT
    
    ; Variable initialization.
    X       DD  134234A4H
    Y       DD  42345B24H
    Z       DD  24539857H
    result  DD  ?
    
; Data segment ends.
DATA ENDS

; Code segment begins.
CODE SEGMENT
    
    ; Bind the registers with the segments.
    ASSUME  :   DS:DATA CS:CODE
          
    START:
    
    ; Move the address of Data segment to DS register.
    MOV AX  ,   DATA
    MOV DS  ,   AX
    
    ; Evaluate the expression.
    MOV AL                  ,   BYTE PTR X
    ADD AL                  ,   BYTE PTR Y
    MOV AH                  ,   BYTE PTR X+1
    ADC AH                  ,   BYTE PTR Y+1
    MOV DL                  ,   BYTE PTR X+2
    ADC DL                  ,   BYTE PTR Y+2
    MOV DH                  ,   BYTE PTR X+3
    ADC DH                  ,   BYTE PTR Y+3
    ADD AL                  ,   24H
    ADC AH                  ,   00H
    SUB AL                  ,   BYTE PTR Z
    SBB AH                  ,   BYTE PTR Z+1
    SBB DL                  ,   BYTE PTR Z+2
    SBB DH                  ,   BYTE PTR Z+3
    MOV BYTE PTR result     ,   AL
    MOV BYTE PTR result+1   ,   AH 
    MOV BYTE PTR result+2   ,   DL     
    MOV BYTE PTR result+3   ,   DH  
    
; Code segment ends.
CODE ENDS

; START ends.
END START
