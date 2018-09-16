; OBJECTIVE : To swap two numbers.
; APPROACH  : Use MOV operation.

; Variables initialization.
DATA SEGMENT  

    NUM1 DB 20H
    NUM2 DB 45H
    
DATA ENDS 

CODE SEGMENT  
    
    ASSUME DS:DATA CS:CODE
    
    START: 
    
    ; MOVING ADDRESS OF DATA TO DS(DATA SEGMENT)
     
    MOV AX  , DATA
    MOV DS  , AX
    
    MOV AL  , NUM1
    MOV BL  , NUM2
    MOV NUM1, BL  
    MOV NUM2, AL
     
CODE ENDS

END START
