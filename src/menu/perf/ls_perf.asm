; List all employees monthly performance in a tabular form
; Employees without monthly performance will instead have "N/A" shown
;   - Employee ID
;   - Employee Name
;   - Employee Ordinary Rate of Pay
;   - Employee hours worked
;   - Employee overtime hours worked
;   - Employee public holiday hours worked
list_performance proc

    push bx
    push cx

    puts LIST_PERFORMANCE_HEADER

    lea bx, employees

    xor ch, ch  ; clear ch for cl
    mov cl, .number_of_emps

    print_all:
        call print_performance_row
        add bx, size employee
        loop print_all

    call press_any_key_to_continue

    pop cx
    pop bx
    ret

list_performance endp


; Print employee monthly performance in a row. Used with list_performance
; Params
;   bx: pointer to employee
print_performance_row proc

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

    ; print work hours
    call print_performance_row_hrs

    add dl, 10
    call set_cursor_pos

    ; print overtime hours
    call print_performance_row_ot

    add dl, 8
    call set_cursor_pos

    ; print public holiday hours
    call print_performance_row_ph

    putc 10

    pop dx
    pop cx
    pop ax
    ret

print_performance_row endp


print_performance_row_hrs proc

    cmp [bx].filled_performance, 0
    je is_na

    putn [bx].hours_worked
    ret

is_na:
    puts NA
    ret

print_performance_row_hrs endp


print_performance_row_ot proc

    cmp [bx].filled_performance, 0
    je is_na

    putn [bx].overtime_hours
    ret

is_na:
    puts NA
    ret

print_performance_row_ot endp


print_performance_row_ph proc

    cmp [bx].filled_performance, 0
    je is_na

    putn [bx].holiday_hours
    ret

is_na:
    puts NA
    ret

print_performance_row_ph endp