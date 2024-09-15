; Script to generate example employee datas
generate_emp_data proc

    push bx

    lea bx, employees

    ; call set_emp_id
    inc .number_of_emps
    insert_emp EMP_NAME1 5 JOB_FULLTIME ORP_FULLTIME 160 TRUE TRUE TRUE
    add bx, size employee

    inc .number_of_emps
    insert_emp EMP_NAME2 4 JOB_PARTTIME ORP_PARTTIME 0 FALSE FALSE FALSE
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

        push si  ; si is consumed by compare_string
        lea di, [bx].emp_name
        call compare_string
        pop si

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
    call find_employee
    jne emp_not_found

    ; employee found
    ret  ; leave

prompt_employee_ctrlc:
    cmp prompt_emp_id[0], "0"  ; set zf = 1
    ret

not_valid_id:
    puts NOT_VALID_ID_MSG
    jmp prompt_employee_loop

emp_not_found:
    puts EMP_NOT_FOUND_MSG
    jmp prompt_employee_loop


prompt_employee endp

;
; Macros
;
insert_emp macro name, name_length_b, job_type, orp, pto, has_epf, has_socso, has_eis

    call set_emp_id

    mov [bx].emp_name_length
    strcpy emp_name1 [bx].emp_name name_length_b

    mov [bx].job_type, job_type

    movdw orp [bx].orp

    mov [bx].pto, pto

    mov [bx].has_epf, has_epf
    mov [bx].has_socso, has_socso
    mov [bx].has_eis, has_eis

endm