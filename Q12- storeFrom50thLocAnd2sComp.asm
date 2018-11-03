; OBJECTIVE : To store 5 words starting from 50th byte of segment.
;             Find and store their 2's complement starting from 60th byte of segment.
; APPROACH  : 

; Data segment begins.  
DATA SEGMENT    
    
    ; Variables initialization.
                            
    ; Skip 50 locations.                        
    temp         DB  50 DUP(?)
    
    ; Allocating space for 5 words.
    wordArray    DW  0000000000000000B, 0001010111110000B, 0011000110101011B, 0000101010000000B, 1111111111111111B 
    
    ; Allocatig space to store the 2's complements of each word.
    2sComp       DW  5  DUP(?) 
    ; Result, 2sComp = 0000000000000000B, 1110101000010000B, 1100111001010101B, 1111010110000000B, 0000000000000001B   
    
    ; Size of wordArray
    size         DW  5 

; Data segment ends.    
DATA ENDS

; Code segment begins.
CODE SEGMENT 
    
    ; Bind the segments with corresponding registers.
    ASSUME  :   DS:DATA CS:CODE 
    
    ; Program starts.
    START: 
        
        ; Move the address of DATA segment to DS register.
        MOV AX  ,   DATA    
        MOV DS  ,   AX   
        
        ; Initialize registers.
        MOV CX  ,   size
        MOV SI  ,   0
        
        REPEAT:  
        
            ; Move a word from wordArray to AX register.
            MOV AX          ,   wordArray[SI] 
            
            ; Complement AX- 1's complement.
            NOT AX
            
            ; Add 1 to AX.
            ADD AX          ,   1 
            
            ; AX contains 2's complement, move it to 2sComp array.
            MOV 2sComp[SI]  ,   AX
            
            ; Increment SI by 2. 
            ADD SI          ,   2
            
        ; Loop to repeat.
        LOOP REPEAT
        
; Code segment ends.        
CODE ENDS

; Program ends.
END START
