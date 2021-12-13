INCLUDE "EMU8086.INC"
.MODEL SMALL
.STACK 100H
   
.DATA
    A DW ? 
    A2 DW ?
    I DW ?
    CARRY DB ?
    CNT DW 0H 
    TMP DW ?
    ARRAY DB 10 DUP (0H)
    
    ARRAY2 DB 10 DUP (0H)   
    
   
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
        PRINT "ENTER NUMBER 1: "
        PRINTN 
        MOV BX,0H              
        MOV CX,4
        ; FOR INPUT NUMBER 1
        TOP:
            ;   TAKING INPUT
            MOV AH,1
            INT 21H
            
            ;COMPARE FOR NUMBER OR LETTER
            CMP AL,39h
            JG LETTER1
            
            ;   TAKING THE FIRST 4 BIT FROM THE INPUT BY DOING AND 
            AND AL,0FH
            ;   MAKING ALL ELEMENTS ZERO OF DX REGISTER (16 BIT)
            JMP SHIFT1
            
       LETTER1:
            SUB AL,37H
            
            XOR DX,DX
            
       SHIFT1:    
            ;   SHIFTING LEFT BX TO MAKE SPACE FOR THE NEW NUMBER
            SHL BX,4
            ;   ADDING THE NEW NUMBER WITH OLD NUMBERS
            OR BL,AL
            
            
            LOOP TOP
        XCHG A,BX 
        PRINTN
        PRINT "ENTER NUMBER 2:"
        PRINTN
        MOV BX,0H
        MOV CX,4
          ; FOR INPUT NUMBER 2
        TOP3:
            ;   TAKING INPUT
            MOV AH,1
            INT 21H 
            
            ;COMPERING FOR NUMBER OR LETTER
            
            CMP AL,39h
            JG LETTER2
            
            
            ;   TAKING THE FIRST 4 BIT FROM THE INPUT BY DOING AND 
            AND AL,0FH
            ;   MAKING ALL ELEMENTS ZERO OF DX REGISTER (16 BIT)
            JMP SHIFT2
        LETTER2:
            SUB AL,37H
            
            
            XOR DX,DX 
            
        SHIFT2:
           
            ;   SHIFTING LEFT BX TO MAKE SPACE FOR THE NEW NUMBER
            SHL BX,4
            ;   ADDING THE NEW NUMBER WITH OLD NUMBERS
            OR BL,AL
            
           
            LOOP TOP3
                
         XCHG A2,BX
         ;MOV DX,A
         ;ADD BX,DX   ; ADDING
         
         PRINTN
         PRINTN
         
         ;  FOR CONVERTING HEX TO DECIMAL NUMBER 1
         
          MOV AX,A
          
          
          MOV I,0D 
          MOV CX,00h
          MOV BX,0Ah
          HEXLOOP1:
            MOV DX,0
            DIV BX
            ADD DL,'0'
            PUSH DX
            INC CX
            CMP AX,0AH
            JGE HEXLOOP1
            ADD AL,'0'
             
            XCHG BX,I
            MOV ARRAY [BX], AL 
            AND ARRAY[BX],0FH
            INC BX 
          HEXLOOP2:
            POP AX
            
            XCHG ARRAY [BX], AL
             AND ARRAY[BX],0FH
            INC BX 
            LOOP HEXLOOP2
             
            MOV ARRAY[BX],0FH
             
            ; FOR REVERSING THE ARRAY WHICH CONTAINS 1ST NUMBER
            MOV CX,5
            MOV BX,0H
            ETIQ1:
                CMP ARRAY[BX],9H
                JG DONE
                
                MOV DL,ARRAY[bx]
                PUSH DX
                INC BX
                LOOP ETIQ1 
             
             
      DONE:       
             
            PRINTN
            PRINT "REVERSE OF 1ST NUMBER: "
            PRINTN 
            ;PRINTING THE REVERSED DECIMAL NUMBER
            MOV CX,5
            MOV BX,0H
            go:  
              
            
                CMP ARRAY[BX],9H
                JG DONE2
                POP AX
                MOV ARRAY[BX],AL
                 AND ARRAY[BX],0FH
                MOV AH,2
                mov DL,ARRAY[BX]
                ADD DL,30H
                INT 21H
                INC BX
            

              
            LOOP GO
            
       DONE2:
     
              PRINTN
              PRINTN
            
            ;  FOR CONVERTING HEX TO DECIMAL NUMBER 2
         
          
          XCHG AX,A2
          
          
          MOV I,0D 
          MOV CX,00h
          MOV BX,0Ah
          
          HEXLOOP11:
            MOV DX,0
            DIV BX
            ADD DL,'0'
            PUSH DX
            INC CX
            CMP AX,0AH
            JGE HEXLOOP11
            ADD AL,'0'
             
            XCHG BX,I
            MOV ARRAY2 [BX], AL
             AND ARRAY2[BX],0FH
            INC BX 
          HEXLOOP22:
            POP AX
            
            MOV ARRAY2 [BX], AL
             AND ARRAY2[BX],0FH
            INC BX 
            LOOP HEXLOOP22 
            
            MOV ARRAY[BX],0FH
            
                              
                              
            ; REVERSING THE ARRAY WHICH CONTAINS 2ND NUMBER
            MOV CX,5
            MOV BX,0h
            ETIQ2:    
            
                CMP ARRAY[BX],9H
                JG DONE3
                MOV DL,ARRAY2[BX]
                PUSH DX
                INC BX
                LOOP ETIQ2
          DONE3:
          
          
            PRINTN
            PRINT "REVERSE OF 2ND NUMBER: "
            PRINTN  
            
            ;PRINTING THE REVERSED ARRAY
            MOV CX,5
            MOV BX,0H
            GO1:  
               
            
            CMP ARRAY[BX],9H
            JG DONE22
            
            POP AX
            MOV ARRAY2[BX],AL
             AND ARRAY2[BX],0FH 
            MOV AH,2
            MOV DL,ARRAY2[BX]
            ADD DL,30H
            INT 21H
            INC BX
            
              
              
            LOOP GO1  
            
            
            DONE22:
            
          
            
            DEC BX
            ;   PRINTING OUTPUT
            
            MOV AL,0FH
            MOV AH,0H
            PUSH AX
            MOV CX,5H
            MOV BX,0H
            MOV CARRY,0H
            
            GO3:  
             
             MOV AX,0H  
            MOV Al,ARRAY[BX]
            ADD Al,CARRY
            ADD Al,array2[bx]
               
            AAM            ; ADJUSTING ASCII VALUE OF THE SUMMATION
            ADD AX,3030H
               
            PUSH AX
                  
            SUB AH,30H      
            
            CMP AH,0H
            JE YESS
            
            MOV CARRY,1H
            JMP END
            
 YESS:       
            MOV CARRY,0H     
            JMP END
                
 END:       
            INC BX
            
            CMP ARRAY[BX],0FH
            JE JSSS
            
            LOOP GO3
    JSSS:       
           PRINTN
           PRINT "THE SUM OF TWO NUMBER IS: "
           PRINTN
           
           CMP CARRY,0H
           JE PNT
           
           
           MOV AH,02H
           MOV Dl,CARRY
           ADD DX,30H
           INT 21H
           
       PNT:
           
           
           
           MOV CX,6
           LOOPX:
           
            
                POP AX
                
                
                CMP AL,0FH
                JE ENDSS
                
                MOV AH,02H
                MOV DL,AL
                INT 21H 
                LOOP LOOPX 
           
         ENDSS:      
               
            
            MAIN ENDP
    
    END MAIN