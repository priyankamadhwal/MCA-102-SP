; OBJECTIVE : Implement Binary search for byte array.
; APPROACH  : Compare the element to be searched with middle element of sorted array (ascending).
;             If equal, then element found, print position.
;             If not equal, then divide array in 2 halves:
;                           if element is greater than middle element, continue search in upper half.
;                           if element is less than middle element, continue search in lower half. 

; Data segment begins.
DATA SEGMENT
    
    ; Variables initialization.
    
    ; Allocating space for byte array in sorted(ascending) order and its size.
    myArray      DB  1, 2, 3, 4, 5, 6
    size         DW  6 
    
    ; Messages to be displayed.
    main_msg     DB  13,10,  "Enter the element you want to find : $" 
    succ_msg     DB  13,10,  "Success!!! Element found at position : $"
    fail_msg     DB  13,10,  "Failure!!! Element not found.$" 
    
    ; Allocating space for the element which is to be searched.
    toFind       DB  ? 
    
    ; Allocating space to store the position of element, if found.
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
        
        ; SI contains lower limit and DI contains upper limit.
        ; SI<-0, DI<-size-1
        MOV SI      ,   0  
        MOV DI      ,   size
        DEC DI
        
        ; BL<-2, used in division by 2. 
        MOV BL      ,   2
        
        SEARCH:
            
            ; If SI is greater than DI, then jump to NOTFOUND.
            CMP SI  ,   DI
            JA  NOTFOUND
            
            ; Find middle index. AX<-(SI+DI)/2             
            MOV AX  ,   SI
            ADD AX  ,   DI
            DIV BL       
            
            ; Clear AH which contains remainder.
            MOV AH  ,   00H                     
            
            ; Move the middle index to BP register.
            MOV BP  ,   AX       
            
            ; Move an element from myArray to AL register.       
            MOV AL  ,   myArray[BP]
            
            ; Compare the contents of AL with toFind.
            CMP toFind ,   AL 
            
            JE  FOUND       ; If toFind==AL, jump to FOUND. 
            JA  UPPER       ; If toFind>AL, jump to UPPER.
            JB  LOWER       ; If toFind<AL, jump to LOWER. 
         
         ; Calculate next lower limit.   
         UPPER:
            INC BP 
            MOV SI  ,   BP
            JMP SEARCH
            
         ; Calculate next upper limit.
         LOWER:
            DEC BP 
            JS  NOTFOUND
            MOV DI  ,   BP
            JMP SEARCH 
             
        
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
            INC BP
            MOV pos  , BP
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
