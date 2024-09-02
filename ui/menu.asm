MAIN_MENU PROC

    MENU:
        call print_menu_options

        SCANC SEL
        PUTC 10
        PUTC 10

        CMP SEL,"1"
        JE ADD_EMP
        
        CMP SEL,"2"
        JE LIST_EMP
        
        CMP SEL,"3"
        JE ADD_EMP_PERFORMANCE
        
        CMP SEL,"4"
        JE LIST_EMP_PAYCHECK
        
        CMP SEL,"5"
        JE VIEW_EMP_DETAIL

        CMP SEL,"6"
        JE MAIN_MENU_EXIT
        
        PUTS WRONG
        JMP MENU
    
    ADD_EMP:
        CALL create_emp
        JMP MENU
    
    LIST_EMP:
        CALL list_all_employee
        JMP MENU
    
    ADD_EMP_PERFORMANCE:

        JMP MENU

    LIST_EMP_PAYCHECK:

        JMP MENU

    VIEW_EMP_DETAIL:

        JMP MENU

    MAIN_MENU_EXIT:
        PUTS EXIT_MSG
    
    RET

MAIN_MENU ENDP

print_menu_options PROC

    PUTC 10
    PUTC 10

    PUTS WELCOME
    PUTS LINE
    PUTS SEL1
    PUTS SEL2
    PUTS SEL3
    PUTS SEL4
    PUTS SEL5
    PUTS SEL6
    PUTS PROMPT

    ret

print_menu_options ENDP