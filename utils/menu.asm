.MODEL SMALL
.STACK 100
.DATA
    WELCOME DB "Diu, what 7 u want. U come here for what???", 10, "$"
    SEL1 DB "1 - Store Employee Information la", 10, "$"
    SEL2 DB "2 - View all ur cb frens details", 10, "$"
    SEL3 DB "3 - Set ur mom monthly performance", 10, "$"
    SEL4 DB "4 - Show all ur slave's monthly paycheck", 10, "$"
    PROMPT DB "Pick one or u suck: $"
    WRONG DB "OI PICK 1-4 U GO PICK WHAT?? MEMANG SOHAI PUNYA ORANG", 10, "$"
    SEL DB ?

.CODE
    INCLUDE PRINT.ASM
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    PUTS WELCOME
    PUTS SEL1
    PUTS SEL2
    PUTS SEL3
    PUTS SEL4
    PUTS PROMPT
    PUTS WRONG




    EXIT:
        MOV AX,4C00H
        INT 21H
MAIN ENDP
END MAIN