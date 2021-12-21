include "emu8086.inc"
.model small
.stack
.data
    val1 db 41h
    val2 db 61h
    val3 db 1h
.code

main proc
    mov ax, @data
    mov ds,ax
    
    mov cx,26
    top:
        mov dl,val1        
        mov ah,2
        int 21h
        
        mov dl,val2        
        mov ah,2
        int 21h
        mov al,5
        
        cmp al,val3
        je five
        print " "

        jmp end
five:   
       printn
       mov val3,0h

end:        
        inc val1
        inc val2
        inc val3
        loop top
    
    
    
    mov ax,4c00h
    int 21h

main endp
end main