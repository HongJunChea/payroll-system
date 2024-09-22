insert_emp macro name, name_length_b, job_type, orp, pto, has_epf, has_socso, has_eis

    push ax

    call set_emp_id

    strcpy name [bx].emp_name name_length_b

    mov al, job_type
    mov [bx].job_type, al

    movdw orp [bx].orp

    mov ax, pto
    mov [bx].pto, pto

    mov al, has_epf
    mov [bx].has_epf, al

    mov al, has_socso
    mov [bx].has_socso, al

    mov al, has_eis
    mov [bx].has_eis, al

    pop ax

endm


; Script to generate example employee datas
generate_emp_data proc

    push bx

    lea bx, employees

    ; call set_emp_id
    insert_emp EMP_NAME1 5 JOB_FULLTIME ORP_FULLTIME 5 TRUE TRUE TRUE
    mov [bx].filled_performance, 1
    mov [bx].hours_worked, 160
    mov [bx].monthly_leaves, 0
    mov [bx].overtime_hours, 8
    mov [bx].holiday_hours, 8
    call process_employee_performance
    inc .number_of_emps
    add bx, size employee

    insert_emp EMP_NAME2 4 JOB_PARTTIME ORP_PARTTIME 0 FALSE FALSE FALSE
    inc .number_of_emps
    add bx, size employee

    insert_emp EMP_NAME3 3 JOB_PARTTIME ORP_PARTTIME 0 FALSE FALSE FALSE
    inc .number_of_emps
    add bx, size employee

    insert_emp EMP_NAME4 5 JOB_FULLTIME ORP_FULLTIME 7 TRUE TRUE TRUE
    inc .number_of_emps
    add bx, size employee

    insert_emp EMP_NAME5 5 JOB_FULLTIME ORP_FULLTIME 5 TRUE TRUE TRUE
    inc .number_of_emps
    add bx, size employee

    insert_emp EMP_NAME6 4 JOB_FULLTIME ORP_FULLTIME 5 TRUE TRUE TRUE
    inc .number_of_emps
    add bx, size employee

    insert_emp EMP_NAME7 4 JOB_PARTTIME ORP_PARTTIME 0 FALSE FALSE FALSE
    inc .number_of_emps
    add bx, size employee

    insert_emp EMP_NAME8 3 JOB_PARTTIME ORP_PARTTIME 0 FALSE FALSE FALSE
    inc .number_of_emps
    add bx, size employee

    insert_emp EMP_NAME9 3 JOB_FULLTIME ORP_FULLTIME 10 TRUE TRUE TRUE
    inc .number_of_emps
    add bx, size employee

    insert_emp EMP_NAME10 3 JOB_FULLTIME ORP_FULLTIME 8 TRUE TRUE TRUE
    inc .number_of_emps
    add bx, size employee

    pop bx
    ret

generate_emp_data endp


; find employee pointer to given the employee id
; Params
;   si: employee id
; Returns
;   bx: the employee pointer
;   zf: 1 = not found
;       0 = found
find_employee proc

    lea bx, employees

    xor ch, ch
    mov cl, .number_of_emps

    sub bx, size employee       ; offset the initial add in the loop
    find_employee_loop:
        add bx, size employee   ; add sets zf, no good

        lea di, [bx].emp_id
        call compare_string

        loopne find_employee_loop

    ret

find_employee endp


; prompt user to select an employee with id
; Returns
;   bx: the employee pointer
;   zf: 1 = not found
;       0 = found
prompt_employee proc

prompt_employee_loop:
    puts PROMPT_EMP_MSG

    mov ch, length .input_buffer
    lea di, .input_buffer
    call input_string

    ; check if input was terminated early
    cmp dl, 1
    je prompt_employee_ctrlc

    ; check valid id
    cmp .input_buffer[0], "E"
    jne not_valid_id

    ; check can find employee
    lea si, .input_buffer
    call find_employee
    jne emp_not_found

    ; employee found
    ret  ; leave

prompt_employee_ctrlc:
    cmp .input_buffer[0], "0"  ; set zf = 1
    ret

not_valid_id:
    puts NOT_VALID_ID_MSG
    jmp prompt_employee_loop

emp_not_found:
    puts EMP_NOT_FOUND_MSG
    jmp prompt_employee_loop


prompt_employee endp
