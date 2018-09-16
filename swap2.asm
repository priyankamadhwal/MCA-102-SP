; OBJECTIVE: To swap two numbers.
; APPROACH : Use XCHG instruction.

; Variables initialization.
DATA SEGMENT
    
    NUM1    DB  35H
    NUM2    DB  50H

DATA ENDS

; Code section
CODE SEGMENT 
    
    ASSUME  DS:DATA CS:CODE
    
    START:   
    
    ; Move the address of DATA segment to DS register.
    MOV AX  ,   DATA
    MOV DS  ,   AX
    
    ;Swapping the numbers using XCHG
    MOV     AL  ,   NUM1
    XCHG    AL  ,   NUM2
    MOV     NUM1,   AL

CODE ENDS 
END START
