; List all employees monthly salary in a tabular form
; Employees without monthly performance will instead have "N/A" shown
;
list_pay proc

    push bx
    push cx

    puts LIST_PAY_HEADER

    lea bx, employees

    xor ch, ch  ; clear ch for cl
    mov cl, .number_of_emps

    list_all_pay:
        call print_pay_row
        add bx, size employee
        loop list_all_pay

    call press_any_key_to_continue

    pop cx
    pop bx
    ret

list_pay endp


; Print employee monthly performance in a row. Used with list_pay
; Params
;   bx: pointer to employee
print_pay_row proc

    push ax
    push cx
    push dx

    call get_cursor_pos

    ; print employee id
    puts [bx].emp_id

    add dl, 13
    call set_cursor_pos

    ; print employee name
    putsn [bx].emp_name 14

    add dl, 15
    call set_cursor_pos

    ; print rate
    putf [bx].orp

    add dl, 6
    call set_cursor_pos

    ; print salary
    call print_pay_row_salary

    putc 10

    pop dx
    pop cx
    pop ax
    ret

print_pay_row endp


print_pay_row_salary proc

    cmp [bx].filled_performance, 0
    je pay_is_na

    call calculate_total
    putf payroll.total
    ret

pay_is_na:
    puts NA
    ret

print_pay_row_salary endp