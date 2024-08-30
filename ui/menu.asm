.MODEL SMALL
.STACK 100
.DATA
    WELCOME DB "Welcome to MKH Payroll System", 10, "$"
    LINE    DB "================================", 10, "$"
    SEL1    DB "1 - Store employee information", 10, "$"
    SEL2    DB "2 - View all employees details", 10, "$"
    SEL3    DB "3 - Set employee monthly performance", 10, "$"
    SEL4    DB "4 - View all employees monthly paycheck", 10, "$"
    SEL5    DB "5 - Exit program", 10, "$"
    PROMPT  DB "Please select (1 - 4): $"
    WRONG   DB "Incorrect choice, please try again.", 10, "$"
    LEAVE   DB "Exiting program....", 10, "$"
    SEL     DB ?

.CODE
    INCLUDE ..\UTILS\PRINT.ASM
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MENU:
        PUTS WELCOME
        PUTS LINE
        PUTS SEL1
        PUTS SEL2
        PUTS SEL3
        PUTS SEL4
        PUTS SEL5
        PUTS PROMPT
        SCANC SEL
        CMP SEL,"1"
        JE EMP_INFO
        CMP SEL,"2"
        JE EMP_DET
        CMP SEL,"3"
        JE EMP_PERF
        CMP SEL,"4"
        JE EMP_PC
        CMP SEL,"5"
        JE EXIT
        PUTS WRONG
        JMP MENU
    
    EMP_INFO:

        JMP MENU
    
    EMP_DET:

        JMP MENU

    
    EMP_PERF:

        JMP MENU

    EMP_PC:

        JMP MENU

    EXIT:
        PUTC 10
        PUTS LEAVE
        MOV AX,4C00H
        INT 21H
MAIN ENDP
END MAIN