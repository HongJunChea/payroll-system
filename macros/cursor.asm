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

END