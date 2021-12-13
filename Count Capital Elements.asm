INCLUDE "EMU8086.INC"
.MODEL SMALL
.STACK 100H
.DATA
    CONST EQU 100 
    A DB ?
    INP DB ?
    CNT DB 0H
.CODE
    MAIN PROC
        
        
        MOV CX,10
        TOP:
           ;TAKING INPUT
           MOV AH,1
           INT 21H
           
           MOV INP,AL
           MOV DL,41H
           ;COMPERING
           CMP DL,INP
           JG YES1
           
           ;2ND COMPERING
           MOV DL,5AH
           CMP DL,INP
           JL YES1      
                
           ; COUNTING     
           INC CNT     
YES1:           
           
                
           LOOP TOP
        ;PRINTING
        PRINTN
        PRINT "THE CAPITAL ELEMENTS ARE: "
        MOV DL,CNT
        ADD DL,30H
        MOV AH,2
        INT 21H
        
        MOV AH,4CH
        INT 21H
        
        MAIN ENDP
    END MAIN