CURSOROFF       MACRO
        PUSH    AX
        PUSH    CX

        MOV     AH, 1
        MOV     CH, 28h
        MOV     CL, 09h
        INT     10h

        POP     CX
        POP     AX
ENDM


CURSORON        MACRO
        PUSH    AX
        PUSH    CX

        MOV     AH, 1
        MOV     CH, 08h
        MOV     CL, 09h
        INT     10h

        POP     CX
        POP     AX
ENDM


GOTOXY  MACRO   col, row
        PUSH    AX
        PUSH    BX
        PUSH    DX

        MOV     AH, 02h
        MOV     DH, row
        MOV     DL, col
        MOV     BH, 0
        INT     10h
        
        POP     DX
        POP     BX
        POP     AX
ENDM


CLEAR_SCREEN PROC FAR
    PUSH AX ; store registers...
    PUSH DS ;
    PUSH BX ;
    PUSH CX ;
    PUSH DI ;

    MOV AX, 40h
    MOV DS, AX   ; for getting screen parameters.
    MOV AH, 06h  ; scroll up function id.
    MOV AL, 0    ; scroll all lines!
    MOV BH, 07   ; attribute for new lines.
    MOV CH, 0    ; upper row.
    MOV CL, 0    ; upper col.
    MOV DI, 84h  ; rows on screen -1,
    MOV DH, [DI] ; lower row (byte).
    MOV DI, 4Ah  ; columns on screen,
    MOV DL, [DI]
    DEC DL       ; lower col.
    INT 10h

    ; set cursor position to top
    ; of the screen:
    MOV BH, 0  ; current page.
    MOV DL, 0  ; col.
    MOV DH, 0  ; row.
    MOV AH, 02
    INT 10h

    POP DI ; re-store registers...
    POP CX ;
    POP BX ;
    POP DS ;
    POP AX ;

    RET
CLEAR_SCREEN ENDP


END