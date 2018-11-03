; OBJECTIVE :   To evaluate the expression: X+Y+24H-Z, where X, Y and Z are word variables.
; APPROACH  :   Use binary addition and subtraction instructions,
;               extract the data as bytes,
;               perform operations byte-by-byte.

; Data segment begins.
DATA SEGMENT
    
    ; Variable initialization.
    X       DW  1342H
    Y       DW  567CH
    Z       DW  4389H
    result  DW   ?
    
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
    
    ; Evaluate the expression
    MOV AL                ,   BYTE PTR X   ; AL <- X(lower byte)
    ADD AL                ,   BYTE PTR Y   ; AL <- AL + Y(lower byte)
    MOV AH                ,   BYTE PTR X+1 ; AH <- X(higher byte)
    ADC AH                ,   BYTE PTR Y+1 ; AH <- AH + Y(higher byte) + carry
    ADD AL                ,   24H          ; AL <- AL + 24H
    ADC AH                ,   00H          ; AH <- AH + carry(if any)
    SUB AL                ,   BYTE PTR Z   ; AL <- AL - Z(lower byte)
    SBB AH                ,   BYTE PTR Z+1 ; AH <- AH - Z(higher byte) - borrow
    MOV BYTE PTR result   ,   AL           ; result(lower byte) <- AL
    MOV BYTE PTR result+1 ,   AH           ; result(higher byte) <- AH

; Code segment ends.
CODE ENDS

; Program ends. 
END START
