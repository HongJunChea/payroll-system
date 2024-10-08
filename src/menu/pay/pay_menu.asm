; Employee payroll menu
; Consists of 3 options
;   - List a summary of all employee payroll
;   - View full summary of a employee payroll
;   - Exit menu
pay_menu proc

pay_menu_loop:
    call clear_screen
    call print_pay_menu_options

    cmp .sel, "1"
    je list_pay_choice

    cmp .sel, "2"
    je view_pay_choice

    cmp .sel, "3"
    je exit_pay_menu_choice

    puts WRONG
    call press_any_key_to_continue
    jmp pay_menu_loop

list_pay_choice:
    call clear_screen
    call list_pay
    jmp pay_menu_loop

view_pay_choice:
    call clear_screen
    call prompt_employee
    jne pay_menu_loop        ; if emp not found
    call view_pay
    jmp pay_menu_loop

exit_pay_menu_choice:
    puts EXIT_MSG
    ret

pay_menu endp


print_pay_menu_options proc

    puts PAY_MENU_HEADER

    puts SLINE_BORDER

    puts LIST_PAY_OPT
    puts VIEW_PAY_OPT
    puts EXIT_PAY_OPT

    putc 10

    puts PROMPT_PERF_OPT   ; reuse, since same as perf 3 options

    input_char
    mov .sel, al
    putc 10

    ret

print_pay_menu_options endp
