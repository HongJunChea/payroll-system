list_employees PROC
    
    push bx
    push cx

    puts LIST_EMP_HEADER

    lea bx, employees

    xor ch, ch  ; clear ch for cl
    mov cl, .number_of_emps

    print_all:
        call print_employee_row
        add bx, size employee
        loop print_all

    call press_any_key_to_continue

    pop cx
    pop bx
    ret

list_employees ENDP


; print employee info in a row
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
    putsn [bx].emp_name 14

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

