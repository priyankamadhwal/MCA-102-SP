; OBJECTIVE : To evaluate the expression- X+Y+24H-Z,
;             where X, Y and Z are byte variabls.
; APPROACH  : Use the binary addition and subtraction instructions.

; Data segment begins.
DATA SEGMENT
    
    ; Variable initialization.
    X       DB  15H
    Y       DB  30H
    Z       DB  10H
    result  DB  ?
    
; Data segment ends.
DATA ENDS

; Code segment begins.
CODE SEGMENT      
    
    ; Binding registers with segments.
    ASSUME DS:DATA  CS:CODE
    
    START:
    ; Move the address of DATA segment to DS register.
    MOV AX  ,   DATA
    MOV DS  ,   AX
    
    ;Evaluating the expression.
    MOV AL      ,   X       ; AL <- X
    ADD AL      ,   Y       ; AL <- AL + Y
    ADD AL      ,   24H     ; AL <- AL + 24H
    SUB AL      ,   Z       ; AL <- AL - Z
    MOV result  ,   AL      ; result <- AL
    
; Code segment ends.
CODE ENDS
END START
