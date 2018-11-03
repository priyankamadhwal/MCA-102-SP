; OBJECTIVE :   To convert 16-digit Unpacked BCD to Packed BCD.    
; APPROACH  :   Use shift instructions to convert Unpacked BCD to Packed BCD.

; Data segment begins.
DATA SEGMENT     
    
    ; Variables initialization. 
     
    ; Allocating space for 16-digit Unpacked BCD nos. (8 bits = 1 BCD digit)
    upBCD      DB  01H, 02H, 03H, 04H, 05H, 06H, 07H, 08H, 09H, 00H, 04H, 02H, 08H, 08H, 06H, 07H      
    
    ; Allocating space for 16-digit Packed BCD nos. (8 bits = 2 BCD digits)
    pBCD       DB  8 DUP(?)  
    ; After conversion, pBCD = 12H, 34H, 56H, 78H, 90H, 42H, 88H, 67H
    
    ; Loop control variable.
    loopVar     DW  8  
    
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
        
        ; Initialize registers.
        MOV CX  ,   loopVar
        MOV SI  ,   0 
        MOV DI  ,   0 
           
        REPEAT: 
            
            ; Clear AX and carry flag.
            XOR AX  ,   AX
            
            ; Move 2 unpacked BCD digits to AX register. 
            ; eg. AH<-01H, AL<-02H, AX = (0000 0001 0000 0010)
            MOV AH  ,   upBCD[SI]
            INC SI
            MOV AL  ,   upBCD[SI] 
            
            ; Left shift AL by 4, AX = (0000 0001 0010 0000)
            SHL AL  ,   4
            
            ; Right shift AX by 4, AX = (0000 0000 0001 0010)
            SHR AX  ,   4 
            
            ; AL contains 2 packed BCD digits (12H)
            ; Move them to pBCD array.      
            MOV pBCD[DI]    ,   AL
            
            ; Update registers.
            INC DI
            INC SI             
            
        ; Loop to repeat.
        LOOP REPEAT  
        
; Code segment ends. 
CODE ENDS 

; Program ends.
END START
