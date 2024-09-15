perf_menu proc

menu_loop:
    call clear_screen
    call print_perf_menu_option

    cmp .sel, "1"
    je list_perf_opt

    cmp .sel, "2"
    je add_perf_opt

    cmp .sel, "3"
    je exit_menu_choice

    puts WRONG
    call press_any_key_to_continue
    jmp menu_loop

list_perf_opt:
    call clear_screen
    call ls_emps_perf
    jmp menu_loop

add_perf_opt:
    call clear_screen
    call prompt_employee
    jne menu_loop        ; if emp not found
    call add_emp_perf
    jmp menu_loop

exit_menu_choice:
    puts EXIT_MSG
    ret

emp_menu endp


print_perf_menu_options proc

    puts PERF_MENU_HEADER

    puts SLINE_BORDER

    puts LIST_PERF_OPT
    puts ADD_PERF_OPT
    puts EDIT_PERF_OPT

    putc 10

    puts PROMPT_PERF_OPT

    getc .sel
    ret

print_perf_menu_options endp
