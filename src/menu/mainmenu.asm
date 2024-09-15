; Program main menu
; Consists of 4 options
;   - Employee menu
;   - Employee performance menu
;   - Employee pay menu
;   - Exit program
; Program is exited when returned from procedure
main_menu PROC

main_menu_loop:
    call clear_screen
    call print_main_menu_options

    cmp .sel, "1"
    je emp_menu_choice

    cmp .sel, "2"
    je perf_menu_choice

    cmp .sel, "3"
    je pay_menu_choice

    cmp .sel, "4"
    je exit_main_menu_choice

    puts WRONG
    call press_any_key_to_continue
    jmp main_menu_loop

emp_menu_choice:
    call clear_screen
    call emp_menu
    jmp main_menu_loop

perf_menu_choice:
    call clear_screen
    call perf_menu
    jmp main_menu_loop

pay_menu_choice:
    call clear_screen
    call pay_menu
    jmp main_menu_loop

exit_main_menu_choice:
    puts EXIT_MSG
    ret

main_menu ENDP


print_main_menu_options PROC

    puts WELCOME

    puts SLINE_BORDER

    puts EMP_MENU_OPT
    puts PERF_MENU_OPT
    puts PAY_MENU_OPT
    puts EXIT_MENU_OPT

    putc 10

    puts PROMPT_OPT

    input_char
    mov .sel, al
    ret

print_main_menu_options ENDP