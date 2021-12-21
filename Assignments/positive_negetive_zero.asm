include "emu8086.inc"
.model small
.stack
.data
    number db 9h
    
    msg1 db ‘it is positive $’
    msg2 db ‘it is negetive $’
    msg3 db ‘it is zero $’
.code

main proc
    
    mov ax, @data
    mov ds,ax
    ; comparing for zero
    cmp number,0h
    je equal
    
    jmp notzero    
equal:
    ;printing message for zero
    lea dx,msg3
    mov ah,09h
    int 21h
notzero:

    ;comparing for positive
    cmp number,0h
    jg positive
    
    jmp notpositive
    
positive:
     ;printing message for positive
    lea dx,msg1
    mov ah,09h
    int 21h    
notpositive:

    ;comparing for negetive
    cmp number,0h
    jl negetive
    
    jmp notnegetive

negetive:
     ;printing message for negetive
    lea dx,msg2
    mov ah,09h
    int 21h
notnegetive:
 
    mov ax,4c00h
    int 21h

main endp
end main