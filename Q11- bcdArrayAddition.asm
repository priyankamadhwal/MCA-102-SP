; OBJECTIVE: To add the elements of an array where each element is a 4-digit packed BCD number.

; Data segment begins.
DATA SEGMENT    
    
    ; Variables initialization.
    ARR     DW  2222H, 1238H, 1111H
    SIZE    DW  3
    RESULT  DW  ?  
    
; Data segment ends.
DATA ENDS

; Code segment begins.
CODE SEGMENT   
    
    ; Bind the segments with the corresponding registers.
    ASSUME: DS:DATA CS:CODE
    
    START:  
        
        ; Move the address of DATA segment to DS register.
        MOV AX  ,   DATA
        MOV DS  ,   AX
        
        XOR AX  ,   AX
        MOV CX  ,   SIZE
        MOV SI  ,   0 
        
        REPEAT:  
            ADD AL  ,   BYTE PTR ARR[SI]
            INC SI 
            DAA
            ADC AH  ,   BYTE PTR ARR[SI]
            DAA  
            INC SI
        LOOP REPEAT
        
        MOV RESULT  ,   AX  
        
; Code segment ends.         
CODE ENDS           

; Start ends.
END START
