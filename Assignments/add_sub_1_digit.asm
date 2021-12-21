include "emu8086.inc"
.model small
.stack
.data
    val1 db ?
    val2 db ?
    msg1 db ‘enter first number: $’
    
    msg2 db ‘enter second number: $’
.code

main proc
    mov ax, @data
    mov ds,ax
    
    lea dx,msg1
   
    mov ah,09h
    int 21h
    
    mov ah,1
    int 21h
    mov val1,al 
    sub val1,30h
    printn
   
    lea dx,msg2
   
    mov ah,09h
    int 21h
    
    
    mov ah,1
    int 21h
    mov val2,al
    sub val2,30h
    mov ax,0h
    mov al,val1
    add al,val2
    printn
    
    ;adding
    aam
    add ax,3030h
    push ax 
    
       
    
    ;printing comment
    mov dl,val1
    add dl,30h
    mov ah,02h
    int 21h
    print "+"
    mov dl,val2
    add dl,30h
    mov ah,02h
    int 21h
    print "="
    
    pop ax
    
    mov dl,ah
    mov dh,al 
    
    mov ah,02h
    int 21h 
    
     mov dl,dh
    mov ah,02h
    int 21h
    printn
    ;checking which number is bigger
    mov al,val1
    
    cmp al,val2
    jg jumphere
    
    mov dl,val1
    mov al,val2
    mov val1,al
    mov val2,dl
    
        
    
jumphere:
    ; printing comment
    mov dl,val1
    add dl,30h
    mov ah,02h
    int 21h
    print "-"
    mov dl,val2
    add dl,30h
    mov ah,02h
    int 21h
    print "=" 
    
    ;subtracting
    mov al,val1
    sub al,val2
    
       
    mov dl,al
    add dl,30h
    mov ah,02h
    int 21h
    
    
    mov ax,4c00h
    int 21h

main endp
end main