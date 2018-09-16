; OBJECTIVE : To evaluate the expression: X+Y+24H-Z,
;           : where X, Y and Z are word variables.
; APPROACH  : Use binary addition and subtraction instructions.

; Data segment begins.
DATA SEGMENT
    
    ; Variables initialization.
    X       DW  1342H
    Y       DW  567CH
    Z       DW  4389H 
    result  DW ?

; Data segment ends.
DATA ENDS

; Code segment begins.
CODE SEGMENT
    
    ; Binding the registers with segments.
    ASSUME  :   DS:DATA CS:CODE 
    
    START:
    
    ; Move the address of DATA segment to DS register.
    MOV AX  ,   DATA
    MOV DS  ,   AX
    
    ; Evaluate X+Y+24H-Z
    MOV AX      ,   X       ; AX <- X
    ADD AX      ,   Y       ; AX <- AX + Y
    ADD AX      ,   24H     ; AX <- AX + 24H
    SUB AX      ,   Z       ; AX <- AX - Z
    MOV result  ,   AX      ; result <- AX 
    
; Code segment ends.
CODE ENDS
; START ends
END START
