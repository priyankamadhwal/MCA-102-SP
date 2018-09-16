; OBJECTIVE :   To evaluate the expression: X+Y+24H-Z,
;               X, Y and Z are double word variables. 
; APPROACH  :   Perform word-by-word binary operations.

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
    
    ; Move the address of DATA segment to DS register.
    MOV AX  ,   DATA
    MOV DS  ,   AX
    
    ; Evaluate the expression.
    MOV AX                  ,   WORD PTR X   ; AX <- X(lower word)
    ADD AX                  ,   WORD PTR Y   ; AX <- AX + Y(lower word)
    MOV DX                  ,   WORD PTR X+2 ; DX <- X(higher word)
    ADC DX                  ,   WORD PTR Y+2 ; DX <- DX + Y(higher word) + carry
    ADD AX                  ,   24H          ; AX <- AX + 24H
    SUB AX                  ,   WORD PTR Z   ; AX <- AX - Z(lower word)
    SBB DX                  ,   WORD PTR Z+2 ; DX <- DX - Z(higher word) - borrow
    MOV WORD PTR result     ,   AX
    MOV WORD PTR result+2   ,   DX 

; Code segment ends.
CODE ENDS

; START ends.
END START
