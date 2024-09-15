; Prompt user for information for an employee
; Params
;	bx: pointer to the employee
edit_employee proc

	call prompt_employee_name
	call prompt_employee_type
    call prompt_employee_salary

    cmp [bx].job_type, 2
    jne edit_emp_not_ft

    call prompt_employee_pto
edit_emp_not_ft:
    call prompt_employee_epf
    call prompt_employee_socso
    call prompt_employee_eis
    ret

edit_employee endp


; Prompt user to enter name for employee
; Params
;   bx: pointer to the employee
prompt_employee_name proc

    puts NAME_PROMPT

    lea di, [bx].emp
    mov ch, 20
    call input_string
    ret

prompt_employee_name endp


; Prompt user to enter type for employee
; Params
;   bx: pointer to the employee
prompt_employee_type proc

prompt_emp_type_loop:
    puts TYPE_PROMPT
    input_char
    putc 10

    cmp al, "1"
    jb prompt_emp_type_loop
    cmp al, "2"
    ja prompt_emp_type_loop

    mov [bx].job_type, al
    ret

prompt_employee_type endp


; Prompt user to enter salary depending on their job type for employee
; Params
;   bx: pointer to the employee
prompt_employee_salary proc

    cmp [bx].job_type, 1
    je prompt_emp_is_pt
    cmp [bx].job_type, 2
    je prompt_emp_is_ft

    puts EMP_JOB_TYPE_INVALID_MSG
    ret

prompt_emp_is_pt:
    call prompt_employee_hourly
    ret

prompt_emp_is_ft:
    call prompt_employee_monthly
    ret

prompt_employee_hourly proc

prompt_emp_hourly_loop:
    puts HOURLY_PROMPT

    lea di, .input_buffer
    mov ch, length .input_buffer
    call input_string

    lea si, .input_buffer
    call strtol

    cmp dl, 0      ; check strtof error
    je hourly_no_error

    puts INVALID_VALUE_MSG
    jmp prompt_emp_hourly_loop

hourly_no_error:
    fstp [bx].orp
    ret

prompt_employee_hourly endp

prompt_employee_monthly proc

prompt_emp_monthly_loop:
    puts SALARY_PROMPT

    lea di, .input_buffer
    mov ch, length .input_buffer
    call input_string

    lea si, .input_buffer
    call strtof

    cmp dl, 0
    je monthly_no_error

    puts INVALID_VALUE_MSG
    jmp prompt_emp_monthly_loop

monthly_no_error:
    fidiv HOURS_PER_MONTH
    fstp [bx].orp
    ret

prompt_employee_monthly endp

prompt_employee_salary endp


; Prompt user to enter pto hours
; Params
;   bx: pointer to the employee
prompt_employee_pto proc

prompt_emp_pto_loop:
    puts PTO_PROMPT

    lea di, .input_buffer
    mov ch, length .input_buffer
    call input_string

    lea si, .input_buffer
    call strtof

    cmp dl, 0
    je pto_no_error

    puts INVALID_VALUE_MSG
    jmp prompt_emp_pto_loop

pto_no_error:
    mov [bx].pto, ax
    ret

prompt_employee_pto endp


; Prompt user to enter epf yes or no
; Params
;   bx: pointer to the employee
prompt_employee_epf proc

prompt_emp_epf_loop:
    puts EPF_PROMPT

    input_char
    putc 10

    cmp al, "y"
    je prompt_epf_is_true
    cmp al, "Y"
    je prompt_epf_is_true

    cmp al, "n"
    je prompt_epf_is_false
    cmp al, "N"
    je prompt_epf_is_false

    jmp prompt_emp_epf_loop

 prompt_epf_is_true:
	mov [bx].has_epf, 1
    ret

 prompt_epf_is_false:
	mov [bx].has_epf, 0
    ret

prompt_employee_epf endp


; Prompt user to enter socso yes or no
; Params
;   bx: pointer to the employee
prompt_employee_socso proc

prompt_emp_socso_loop:
    puts SOCSO_PROMPT

    input_char
    putc 10

    cmp al, "y"
    je prompt_socso_is_true
    cmp al, "Y"
    je prompt_socso_is_true

    cmp al, "n"
    je prompt_socso_is_false
    cmp al, "N"
    je prompt_socso_is_false

    jmp prompt_emp_socso_loop

prompt_socso_is_true:
	mov [bx].has_socso, 1
    ret

prompt_socso_is_false:
    mov [bx].has_socso, 0
    ret

prompt_employee_socso endp


; Prompt user to enter eis yes or no
; Params
;   bx: pointer to the employee
prompt_employee_eis proc

prompt_emp_eis_loop:
    puts EIS_PROMPT

    input_char
    putc 10

    cmp al, "y"
    je prompt_eis_is_true
    cmp al, "Y"
    je prompt_eis_is_true

    cmp al, "n"
    je prompt_eis_is_false
    cmp al, "N"
    je prompt_eis_is_false

    jmp prompt_emp_eis_loop

prompt_eis_is_true:
	mov [bx].has_eis, 1
    ret

prompt_eis_is_false:
	mov [bx].has_eis, 0
    ret

prompt_employee_eis endp
