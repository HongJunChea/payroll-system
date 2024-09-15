; Lists all employees information in a tabular form
;   - Employee ID
;   - Employee name
;   - Employee Ordinary Rate of Pay
;   - Number of PTO hours
;   - EPF status
;   - SOCSO status
;   - EIS status
list_employees PROC
    
    push bx
    push cx

    puts LIST_EMP_HEADER

    lea bx, employees

    xor ch, ch  ; clear ch for cl
    mov cl, .number_of_emps

    list_all_employee:
        call print_employee_row
        add bx, size employee
        loop list_all_employee

    call press_any_key_to_continue

    pop cx
    pop bx
    ret

list_employees ENDP


; Print employee info in a row. Used with list_employees
; Params:
;   bx: pointer to employee
print_employee_row proc

    push ax
    push cx
    push dx

    call get_cursor_pos

    ; print employee id
    puts [bx].emp_id

    add dl, 13
    call set_cursor_pos

    ; print employee name
    puts [bx].emp_name

    add dl, 15
    call set_cursor_pos

    ; print rate
    putf [bx].orp

    add dl, 6
    call set_cursor_pos

    ; print pto
    putn [bx].pto

    add dl, 6
    call set_cursor_pos

    ; print epf
    mov al, [bx].has_epf
    call print_bool

    add dl, 5
    call set_cursor_pos

    ; print socso
    mov al, [bx].has_socso
    call print_bool

    add dl, 7
    call set_cursor_pos

    ; print eis
    mov al, [bx].has_eis
    call print_bool

    putc 10

    pop dx
    pop cx
    pop ax
    ret

print_employee_row endp

