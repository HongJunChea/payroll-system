MAIN_MENU PROC

    MENU:
        call print_menu_options

        CMP SEL,"1"
        JE ADD_EMP
        
        CMP SEL,"2"
        JE LIST_EMP

        CMP SEL,"3"
        JE EDIT_EMP
        
        CMP SEL,"4"
        JE ADD_EMP_PERFORMANCE
        
        CMP SEL,"5"
        JE LIST_EMP_PAYCHECK
        
        CMP SEL,"6"
        JE VIEW_EMP_DETAIL

        CMP SEL,"7"
        JE MAIN_MENU_EXIT
        
        PUTS WRONG
        JMP MENU
    
    ADD_EMP:
        CALL create_employee
        JMP MENU
    
    LIST_EMP:
        CALL ls_emps
        JMP MENU

    EDIT_EMP:
        call prompt_employee
        jne MENU
        call edit_employee
        JMP MENU
    
    ADD_EMP_PERFORMANCE:
        call prompt_employee
        jne MENU
        call add_emp_perf
        JMP MENU

    LIST_EMP_PAYCHECK:
        call ls_emps_perf
        JMP MENU

    VIEW_EMP_DETAIL:
        call prompt_employee
        jne MENU
        call view_emp_perf
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
    PUTS SEL7
    PUTS PROMPT

    getc SEL
    PUTC 10
    PUTC 10
    ret

print_menu_options ENDP