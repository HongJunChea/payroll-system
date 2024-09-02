generate_emp_data proc

    push bx

    lea bx, employees

    ; call set_emp_id
    inc number_of_employees
    call set_emp_id
    mov [bx].emp_name_length, 5
    strcpy emp_name1 [bx].emp_name 5 
    mov [bx].job_type, 2
    movdw orp_fulltime [bx].orp
    mov [bx].pto, 160
    mov [bx].has_epf, 1
    mov [bx].has_socso, 1
    mov [bx].has_eis, 1

    add bx, size employee

    inc number_of_employees
    call set_emp_id
    mov [bx].emp_name_length, 4
    strcpy emp_name2 [bx].emp_name 4 
    mov [bx].job_type, 1
    movdw orp_parttime [bx].orp
    mov [bx].pto, 0
    mov [bx].has_epf, 0
    mov [bx].has_socso, 0
    mov [bx].has_eis, 0

    add bx, size employee

    pop bx
    ret

generate_emp_data endp