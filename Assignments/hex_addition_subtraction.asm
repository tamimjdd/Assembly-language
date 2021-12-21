include "emu8086.inc"
.model small
.stack
.data
    A DW ? 
    A2 DW ?
    I DW ?
    CARRY Dw ?
    CNT DW 0H 
    TMP DW ?
    msg1 db ‘enter first number: $’
    
    msg2 db ‘enter second number: $’
.code

main proc
    mov ax, @data
    mov ds,ax
    
        MOV BX,0H 
        print "Enter first number: "             
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
            SUB AL,37H  ; SUBSTRACTING FOR GETTING THE REAL HEX VALUE
            
            
            
       SHIFT1:    
            ;   SHIFTING LEFT BX TO MAKE SPACE FOR THE NEW NUMBER
            SHL BX,4
            ;   ADDING THE NEW NUMBER WITH OLD NUMBERS
            OR BL,AL
            
            
            LOOP TOP 
            printn
            print "enter second number: "
        XCHG A,BX     ; PASSING NUMBER 1 TO "A" VERIABLE
        
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
            SUB AL,37H   ; SUBSTRACTING FOR GETTING THE REAL HEX VALUE
            
            
             
            
        SHIFT2:
           
            ;   SHIFTING LEFT BX TO MAKE SPACE FOR THE NEW NUMBER
            SHL BX,4
            ;   ADDING THE NEW NUMBER WITH OLD NUMBERS
            OR BL,AL
            
           
            LOOP TOP3 
            mov a2,bx  
            printn
            print "the summation is: "    
           
           mov ax,a 
           add ax,bx 
           jnc skip
          
           mov carry,01h
           mov bx,ax 
           mov dx,carry
           add dx,30h
           mov ah,2
           int 21h 
           jmp end

skip:        
            mov bx,ax
            
            
end:        
            mov cx,4
           top2:
              xor dx,dx
              rol bx,4
              mov dl,bl
              and dl,0fh 
              
              CMP dl,09h
              JG greater
              
              add dl,30h
              jmp notg
greater:              
              add dl,37h
notg:
              mov ah,2
              int 21h
              
             
              
            loop top2 
            
             printn
             print "the subtraction is: "
            mov ax,a  
            cmp ax,a2
            jg jumphere
            
            mov dx,a
            mov ax,a2
            mov a,ax
            mov a2,dx
            
            mov ax,a
            sub ax,a2
            jmp end2 
            
jumphere:

        sub ax,a2
        
        
end2:       
        mov bx,ax
        mov cx,4
           top4:
              xor dx,dx
              rol bx,4
              mov dl,bl
              and dl,0fh
              
              CMP dl,09h
              JG greater2
              
              add dl,30h
              jmp notg2
greater2:              
              add dl,37h
notg2:
              
              mov ah,2
              int 21h
              
             
              
            loop top4
    
    mov ax,4c00h
    int 21h

main endp
end main