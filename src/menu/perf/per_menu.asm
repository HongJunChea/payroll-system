; Employee monthly performance menu
; Consists of 3 options
;   - List all employee monthly performances. Missing info is filled as N/A
;   - Add employee monthly performance details.
;   - Exit menu
perf_menu proc

perf_menu_loop:
    call clear_screen
    call print_perf_menu_options

    cmp .sel, "1"
    je list_perf_choice

    cmp .sel, "2"
    je add_perf_choice

    cmp .sel, "3"
    je exit_perf_menu_choice

    puts WRONG
    call press_any_key_to_continue
    jmp perf_menu_loop

list_perf_choice:
    call clear_screen
    call list_performance
    jmp perf_menu_loop

add_perf_choice:
    call clear_screen
    call prompt_employee
    jne perf_menu_loop        ; if emp not found
    call set_performance
    jmp perf_menu_loop

exit_perf_menu_choice:
    puts EXIT_MSG
    ret

perf_menu endp


print_perf_menu_options proc

    puts PERF_MENU_HEADER

    puts SLINE_BORDER

    puts LIST_PERF_OPT
    puts ADD_PERF_OPT
    puts EXIT_PERF_OPT

    putc 10

    puts PROMPT_PERF_OPT

    input_char
    mov .sel, al
    putc 10

    ret

print_perf_menu_options endp
