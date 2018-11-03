; OBJECTIVE :   To convert 16-digit Packed BCD to Unpacked BCD and its ASCII value.    
; APPROACH  :   Use shift instructions to convert Packed BCD to Unpacked BCD.
;               Add 30H to each digit to obtain ASCII value.

; Data segment begins.
DATA SEGMENT     
    
    ; Variables initialization. 
     
    ; Allocating space for 16-digit Packed BCD nos. (8 bits = 2 BCD digits)
    pBCD        DB  12H, 34H, 56H, 78H, 90H, 42H, 88H, 67H      
    
    ; Allocating space for 16-digit Unpacked BCD nos. (8 bits = 1 BCD digit)
    upBCD       DB  16 DUP(?)  
    ; After conversion, upBCD = 01H, 02H, 03H, 04H, 05H, 06H, 07H, 08H, 09H, 00H, 04H, 02H, 08H, 08H, 06H, 07H
    
    ; Allocating space to store ASCII value of each digit.
    ascii       DB  16 DUP(00H)
    ; After conversion, ascii = 31H, 32H, 33H, 34H, 35H, 36H, 37H, 38H, 39H, 30H, 34H, 32H, 38H, 38H, 36H, 37H
    ; ASCII VALUES:
    ;               0 = 30H
    ;               1 = 31H
    ;               2 = 32H
    ;               3 = 33H
    ;               4 = 34H
    ;               5 = 35H
    ;               6 = 36H
    ;               7 = 37H
    ;               8 = 38H
    ;               9 = 39H
    
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
            
            ; Move 2 packed BCD digits to AL register. 
            ; eg. AL<-12H, AL = (0001 0010)
            MOV AL  ,   pBCD[SI] 
            
            ; Left shift AX by 4, AX = (0000 0001 0010 0000)
            SHL AX  ,   4
            
            ; Right shift AL by 4, AX = (0000 0001 0000 0010)
            SHR AL  ,   4 
            
            ; AH and AL contains 2 unpacked BCD digits (01H, 02H)
            ; Move them to upBCD array.      
            MOV upBCD[DI]    ,    AH   
            MOV upBCD[DI+1]  ,    AL   
            
            ; Add 30H to each digit in AH and AL to obtain ASCII value.
            ADD AL  ,   30H
            ADD AH  ,   30H 
            
            ; Move the contents of AH and AL to ascii array.
            mov ascii[DI+1]  ,   AL 
            mov ascii[DI]    ,   AH  
            
            ; Update registers.
            ADD DI  ,   2
            INC SI             
            
        ; Loop to repeat.
        LOOP REPEAT  
        
; Code segment ends. 
CODE ENDS 

; Program ends.
END START
