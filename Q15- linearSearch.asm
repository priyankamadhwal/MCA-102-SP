; OBJECTIVE : Implement Linear search for byte array.
; APPROACH  : Compare each element of array with the element to be searched, sequentially.
;             If element is found, print position. 

; Data segment begins.
DATA SEGMENT
    
    ; Variables initialization.
    
    ; Allocating space for byte array and its size.
    myArray      DB  1, 2, 3, 4, 5
    size         DW  5 
    
    ; Messages to be displayed.
    main_msg     DB  13,10,  "Enter the element you want to find : $" 
    succ_msg     DB  13,10,  "Success!!! Element found at position : $"
    fail_msg     DB  13,10,  "Failure!!! Element not found.$" 
    
    ; Allocating space for the element which is to be searched.
    toFind       DB  ? 
    
    ; Allocating space to store the position of that element.
    pos          DW  ?

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
    
        ; Print main_msg.
        MOV AH      ,   09H
		MOV DX      ,   OFFSET main_msg
		INT 21H
		
		; Read input from user.  
		MOV AH      ,   01H
		INT 21H 
		     
		; Conversion, ASCII to HEX.
		SUB AL      ,   30H 
		
		; Store the element which is to be searched at toFind location.
		MOV toFind  ,   AL       
        
        ; Initialize registers.
        MOV SI      ,   0
        MOV CX      ,   size
        
        REPEAT:
            
            ; Move an element from myArray to AL register.              
            MOV AL  ,   myArray[SI]
            
            ; Compare the contents of AL with toFind.
            CMP AL ,   toFind 
            
            ; If equal, jump to FOUND.
            JE  FOUND
            
            ; Increment SI.
            INC SI
            
            ; Loop to REPEAT
            LOOP REPEAT
        
        ; If element not found, print fail_msg.
        NOTFOUND: 
            MOV AH   ,   09H
            MOV DX   ,   OFFSET fail_msg
            INT 21H 
            ; Jump to DONE
            JMP DONE
        
        ; If element found, print succ_msg and position.
        FOUND: 
            MOV AH   ,   09H
            MOV DX   ,   OFFSET succ_msg
            INT 21H 
            ; pos = SI+1
            INC SI
            MOV pos  , SI
            MOV DX   , pos
            ; Conversion, HEX to ASCII
            ADD DX  ,   30H
            ; Print position.
            MOV AH  ,   02H
            INT 21H
            ; Jump to DONE
            JMP DONE
            
        ; Search completes.    
        DONE:
            HLT

; Code segment ends.        
CODE ENDS

; Program ends.
END START
