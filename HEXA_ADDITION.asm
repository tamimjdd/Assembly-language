INCLUDE "EMU8086.INC"
.MODEL SMALL
.STACK 100H
   
.DATA
    A DW ? 
    A2 DW ?
    i dW ?
    CARRY Db ?
    CNT DW 0H 
    TMP DW ?
    array db 10 dup (0h)
    
    array2 db 10 dup (0h)   
    
   
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
            mov dx,0
            div BX
            add dl,'0'
            push dx
            inc cx
            cmp ax,0ah
            jge hexloop1
            add al,'0'
            ;mov [si],al 
            XCHG BX,I
            mov array [bx], al 
            AND ARRAY[BX],0FH
            inc BX 
          hexloop2:
            pop ax
            
            ;mov [si],al
            XCHG array [bx], al
             AND ARRAY[BX],0FH
            inc bx 
            loop hexloop2
             
            MOV ARRAY[BX],0FH
             
            ; FOR REVERSING THE ARRAY WHICH CONTAINS 1ST NUMBER
            mov cx,5
            mov bx,0h
            etiq1:
                CMP ARRAY[BX],9H
                JG DONE
                
                mov dl,array[bx]
                push dx
                inc bx
                loop etiq1 
             
             
      DONE:       
             
             
            ;PRINTING THE REVERSED DECIMAL NUMBER
            mov cx,5
            MOV BX,0H
            go:  
              
            
                CMP ARRAY[BX],9H
                JG DONE2
                pop ax
                mov array[bx],al
                 AND ARRAY[BX],0FH
                MOV AH,2
                mov dl,array[bx]
                ADD DL,30H
                INT 21H
                INC bx
            

              
            loop go
            
       DONE2:
     
              PRINTN
              PRINTN
            
            ;  FOR CONVERTING HEX TO DECIMAL NUMBER 2
         
          
          XCHG AX,A2
          
          
          MOV I,0D 
          MOV CX,00h
          MOV BX,0Ah
          HEXLOOP11:
            mov dx,0
            div BX
            add dl,'0'
            push dx
            inc cx
            cmp ax,0ah
            jge hexloop11
            add al,'0'
            ;mov [si],al 
            XCHG BX,I
            mov array2 [bx], al
             AND ARRAY2[BX],0FH
            INC BX 
          hexloop22:
            pop ax
            
            ; mov [si],al
            mov array2 [bx], al
             AND ARRAY2[BX],0FH
            INC bx 
            loop hexloop22 
            
            MOV ARRAY[BX],0FH
            
            ; REVERSING THE ARRAY WHICH CONTAINS 2ND NUMBER
            mov cx,5
            mov bx,0h
            etiq2:    
            
                CMP ARRAY[BX],9H
                JG DONE3
                mov dl,array2[bx]
                push dx
                inc bx
                loop etiq2
          DONE3:  
            
            ;PRINTING THE REVERSED ARRAY
            mov cx,5
            MOV BX,0H
            go1:  
               
            
            CMP ARRAY[BX],9H
            JG DONE22
            
            pop ax
            mov array2[bx],al
             AND ARRAY2[BX],0FH 
            MOV AH,2
            mov dl,array2[bx]
            ADD DL,30H
            INT 21H
            INC bx
            
              
              
            loop go1  
            
            
            DONE22:
            
            END3:
            
            DEC BX
            ;   PRINTING OUTPUT
            
            MOV AL,0FH
            MOV AH,0H
            PUSH AX
            mov cx,5H
            MOV BX,0H
            MOV CARRY,0H
            
            go3:  
             
             MOV AX,0H  
            MOV Al,ARRAY[BX]
            ADD Al,CARRY
            ADD Al,array2[bx]
               
            aam            ; ADJUSTING ASCII VALUE OF THE SUMMATION
            add ax,3030h
               
            push ax
                  
            SUB AH,30H      
            
            cmp ah,0h
            je yess
            
            MOV CARRY,1H
            jmp end
            
 yess:       
            MOV CARRY,0H     
            JMP END
                
   end:       
            INC BX
            
            CMP ARRAY[BX],0FH
            JE JSSS
            
            loop go3
    JSSS:       
           
           
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
           
            
                pop AX
                
                
                CMP AL,0FH
                JE ENDSS
                
                mov ah,02h
                mov DL,AL
                int 21h 
                LOOP LOOPX 
           
         ENDSS:      
               
            
            MAIN ENDP
    
    END MAIN