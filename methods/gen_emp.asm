generate_emp_data proc

    push bx
    push si

    lea bx, employees
    mov si, 0

    call set_emp_id
    mov [bx][si].emp_name_length, 5
    strcpy emp_name1 [bx][si].emp_name 5
    mov [bx][si].job_type, 2
    push si
    mov cx, 2
    lea si, orp_fulltime
    lea di, [bx][si].orp
    rep movsw
    pop si
    mov [bx][si].pto, 160
    mov [bx][si].has_epf, 1
    mov [bx][si].has_socso, 1
    mov [bx][si].has_eis, 1

    add si, size employee

    call set_emp_id
    mov [bx][si].emp_name_length, 4
    strcpy emp_name2 [bx][si].emp_name 4
    mov [bx][si].job_type, 1
    push si
    mov cx, 2
    lea si, orp_parttime
    lea di, [bx][si].orp
    rep movsw
    pop si
    mov [bx][si].pto, 0
    mov [bx][si].has_epf, 0
    mov [bx][si].has_socso, 0
    mov [bx][si].has_eis, 0

    add si, size employee

    pop si
    pop bx
    ret

generate_emp_data endp