; set information for an employee
; Parameters
;	bx: pointer to the employee
add_emp_perf proc

    cmp [bx].job_type, 1
    je add_emp_perf_pt

    cmp [bx].job_type, 2
    je add_emp_perf_ft

    puts EMPLOYEE_JOB_TYPE_INVALID_MESSAGE
    ret

add_emp_perf_pt:
    call handle_pt_perf
    ret

add_emp_perf_ft:
    call handle_ft_perf
    ret

add_emp_perf endp


handle_ft_perf proc

    push ax

    mov [bx].hours_worked, 160  ; assume 8 hours, 5 days, 4 weeks

    puts PROMPT_LEAVES
    call input_num
    mul EIGHT_W
    mov [bx].monthly_leaves, ax

    puts PROMPT_OT
    call input_num
    mov [bx].overtime_hours, ax

    puts PROMPT_PH
    call input_num
    mov [bx].holiday_hours, ax

    mov [bx].filled_performance, 1

    pop ax

    ret

handle_ft_perf endp



handle_pt_perf proc

    push ax

    puts PROMPT_HOURS_WORKED
    call input_num
    mov [bx].hours_worked, ax

    puts PROMPT_OT
    call input_num
    mov [bx].overtime_hours, ax

    puts PROMPT_PH
    call input_num
    mov [bx].holiday_hours, ax

    mov [bx].filled_performance, 1
    
    pop ax

    ret

handle_pt_perf endp