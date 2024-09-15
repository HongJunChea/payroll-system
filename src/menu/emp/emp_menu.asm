emp_menu proc

menu_loop:
    call clear_screen
    call print_emp_menu_option

    cmp .sel, "1"
    je list_emp_choice

    cmp .sel, "2"
    je add_emp_choice

    cmp .sel, "3"
    je edit_emp_choice

    cmp .sel, "4"
    je exit_menu_choice

    puts WRONG
    call press_any_key_to_continue
    jmp menu_loop

list_emp_choice:
    call clear_screen
    call ls_emps
    jmp menu_loop

add_emp_choice:
    call clear_screen
    call create_employee
    jmp menu_loop

edit_emp_choice:
    call clear_screen
    call prompt_employee
    jne menu_loop        ; if emp not found
    call edit_employee
    jmp menu_loop

exit_menu_choice:
    puts EXIT_MSG
    ret

emp_menu endp


print_emp_menu_options proc

    puts EMP_MENU_HEADER

    puts SLINE_BORDER

    puts LIST_EMP_OPT
    puts ADD_EMP_OPT
    puts EDIT_EMP_OPT
    puts EXIT_EMP_OPT

    putc 10

    puts PROMPT_OPT

    getc .sel
    ret

print_emp_menu_options endp
