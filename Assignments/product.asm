include "emu8086.inc"
.model small
.stack
.data
    val1 db 8h
    val2 db ?
.code

main proc
    mov ax, @data
    mov ds,ax 
    
        MOV BX,0H 
        ;print "Enter first number: "             
        MOV CX,2
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
    
         mov ax,0h
         mov al,bl
                  
                 
         printn
         print "the multiplication of 8 and input value is: " 
         mul val1
         mov bl,al 
         mov cx,2
           top2:
         xor dx,dx
         rol bl,4
         
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
         
    mov ax,4c00h
    int 21h

main endp
end main