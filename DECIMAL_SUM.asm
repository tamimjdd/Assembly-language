INCLUDE "EMU8086.INC"
.MODEL SMALL
.STACK 100H
.DATA
    A DW ? 
    A2 DW ?
    
    CARRY DB 0H 
   
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
         
        MOV BX,0H              
        MOV CX,4
        ; FOR INPUT NUMBER 1
        TOP:
            ;   TAKING INPUT
            MOV AH,1
            INT 21H
            ;   TAKING THE FIRST 4 BIT FROM THE INPUT BY DOING AND 
            AND AL,0FH
            ;   MAKING ALL ELEMENTS ZERO OF DX REGISTER (16 BIT)
            XOR DX,DX
            ;   MOVING AL TO DL
            MOV DL,AL
            ;   SHIFTING LEFT BX TO MAKE SPACE FOR THE NEW NUMBER
            SHL BX,4
            ;   ADDING THE NEW NUMBER WITH OLD NUMBERS
            OR BX,DX
            
            
            LOOP TOP 
                    
        XCHG A,BX   ; STORING THE VALUE IN A SAVE PLACE
    
        MOV BX,0H
        MOV CX,4
          ; FOR INPUT NUMBER 2
        TOP3:
            ;   TAKING INPUT
            MOV AH,1
            INT 21H
            ;   TAKING THE FIRST 4 BIT FROM THE INPUT BY DOING AND 
            AND AL,0FH
            ;   MAKING ALL ELEMENTS ZERO OF DX REGISTER (16 BIT)
            XOR DX,DX
            ;   MOVING AL TO DL
            MOV DL,AL
            ;   SHIFTING LEFT BX TO MAKE SPACE FOR THE NEW NUMBER
            SHL BX,4
            ;   ADDING THE NEW NUMBER WITH OLD NUMBERS
            OR BX,DX
            
            
            LOOP TOP3
            
         PRINTN
         PRINTN
         MOV CX,4 
         MOV AX,0FH
         PUSH AX    ; MAKING THE LAST ELEMENT OF STACK "F" FOR TERMINATION
         ;  FOR PRINT
         TOP2:       
            
            ;   MAKING ALL ELEMENTS ZERO OF DX REGISTER (16 BIT)
            XOR DX,DX
           
            
            ;   MOVING THE FIRST NUMBER INTO THE OUTPUT REGISTER DL
            MOV DL,BL
            ;   ANDING SO THAT WE CAN GET THE FIRST 4 BIT NUMBER
            AND DL,0FH
            ;   ADDING 30 TO PRINT THE CORRECT NUMBER 
            
            ;       FOR ADDING
                                
            
            MOV AX,A
            AND AL,0FH
            ADD AL,DL     ; ADDING
            ADD AL,CARRY  ; ADDING CARRY
            
            AAM         ; FOR ASCII ADJUSTMENT
            ADD AX,3030H    ; FOR GETTING THE REAL NUMBER
            PUSH AX         ; STORING THE VALUE TEMPORARY
            
            
            POP AX 
            
            SUB AH,30H      ; CHECKING FOR CARRY
            CMP AH,0H
            JE YESS         ; IF NO CARRY JUMP
            
            MOV CARRY,1H
            JMP END
            
 YESS:       
            MOV CARRY,0H    ; MAKE CARRY EQUAL ZERO 
            JMP END
            
            
            
           
            
            
            
      
            
            
 END:           

            PUSH AX       ; STORING THE VALUE FOR OUTPUT
            
            ; SHIFTING THE NUMBERS TO GET THE NEXT NUMBER
            SHR A,4        
            SHR BX,4
            
            LOOP TOP2  
            
            PRINTN
            
            
           CMP CARRY,0H   
           JE PNT         ; IF NO CARRY JUMP
           
           ; IF CARRY PRINT THE CARRY
           MOV AH,02H
           MOV Dl,CARRY
           ADD DX,30H
           INT 21H
           
       PNT:
           
           ; PRINT THE OUTPUT FROM THE STACK
           
           MOV CX,6
           LOOPX:
           
            
                pop AX
                
                
                CMP AL,0FH    ; IF THE POPED ELEMENT IS EQUAL "F"
                              ; THEN BREAK THE LOOP
                JE ENDSS
                
                mov ah,02h
                mov DL,AL
                int 21h 
                LOOP LOOPX 
           
         ENDSS:      
            
            
            
            
            MOV AH,4CH
            INT 21H
            
            MAIN ENDP
    
    END MAIN