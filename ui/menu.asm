MAIN_MENU PROC

    MENU:
        PUTC 10

        PUTS WELCOME
        PUTS LINE
        PUTS SEL1
        PUTS SEL2
        PUTS SEL3
        PUTS SEL4
        PUTS SEL5
        PUTS PROMPT

        SCANC SEL
        PUTC 10

        CMP SEL,"1"
        JE EMP_INFO
        
        CMP SEL,"2"
        JE EMP_DET
        
        CMP SEL,"3"
        JE EMP_PERF
        
        CMP SEL,"4"
        JE EMP_PC
        
        CMP SEL,"5"
        JE MAIN_MENU_EXIT
        
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

    MAIN_MENU_EXIT:
        PUTS EXIT_MSG
        RET
MAIN_MENU ENDP