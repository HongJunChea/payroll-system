; Set the monthly performance for a employee
; Parameters
;	bx: pointer to the employee
set_performance proc

    cmp [bx].job_type, 2
    je set_perf_is_ft

    ; parttime
    call prompt_performance_hours

    jmp set_perf_continue

set_perf_is_ft:
    call prompt_performance_days
    call prompt_performance_leaves

set_perf_continue:

    call prompt_performance_ot
    call prompt_performance_ph

    call process_employee_performance
    mov [bx].filled_performance, 1

    ret

set_performance endp


; Prompt user to enter the number of hours worked for employee
; Params
;   bx: pointer to the employee
prompt_performance_hours proc

prompt_perf_hrs_loop:
    puts PROMPT_HOURS_WORKED

    lea di, .input_buffer
    mov ch, length .input_buffer
    call input_string

    lea si, .input_buffer
    call strtol

    cmp dl, 0
    je prompt_perf_hrs_no_error

    puts INVALID_VALUE_MSG
    jmp prompt_perf_hrs_loop

prompt_perf_hrs_no_error:
    mov [bx].pto, ax
    ret

prompt_performance_hours endp


; Prompt user to enter the number of days worked for full time employee
; Params
;   bx: pointer to the employee
prompt_performance_days proc

prompt_perf_days_loop:
    puts PROMPT_DAYS_WORKED

    lea di, .input_buffer
    mov ch, length .input_buffer
    call input_string

    lea si, .input_buffer
    call strtol

    cmp dl, 0
    je prompt_perf_days_no_error

    puts INVALID_VALUE_MSG
    jmp prompt_perf_days_loop

prompt_perf_days_no_error:
    mul EIGHT_B
    mov [bx].pto, ax
    ret

prompt_performance_days endp


; Prompt user to enter the number of days of leaves claimed for employee
; Params
;   bx: pointer to the employee
prompt_performance_leaves proc

prompt_perf_leaves_loop:
    puts PROMPT_LEAVES

    lea di, .input_buffer
    mov ch, length .input_buffer
    call input_string

    lea si, .input_buffer
    call strtol

    cmp dl, 0
    je prompt_perf_leaves_no_error

    puts INVALID_VALUE_MSG
    jmp prompt_perf_leaves_loop

prompt_perf_leaves_no_error:
    mul EIGHT_B
    mov [bx].pto, ax
    ret

prompt_performance_leaves endp


; Prompt user to enter the number of overtime hours worked for employee
; Params
;   bx: pointer to the employee
prompt_performance_ot proc

prompt_perf_ot_loop:
    puts PROMPT_OT

    lea di, .input_buffer
    mov ch, length .input_buffer
    call input_string

    lea si, .input_buffer
    call strtol

    cmp dl, 0
    je prompt_perf_ot_no_error

    puts INVALID_VALUE_MSG
    jmp prompt_perf_ot_loop

prompt_perf_ot_no_error:
    mov [bx].pto, ax
    ret

prompt_performance_ot endp


; Prompt user to enter the number of public holiday hours worked for employee
; Params
;   bx: pointer to the employee
prompt_performance_ph proc

prompt_perf_ph_loop:
    puts PROMPT_PH

    lea di, .input_buffer
    mov ch, length .input_buffer
    call input_string

    lea si, .input_buffer
    call strtol

    cmp dl, 0
    je prompt_perf_ph_no_error

    puts INVALID_VALUE_MSG
    jmp prompt_perf_ph_loop

prompt_perf_ph_no_error:
    mov [bx].pto, ax
    ret

prompt_performance_ph endp


; Process and calculate employee hours after entering
; Do
;   - take away ot and ph hours from hours worked
;   - calculate claimed pto
; Params
;   bx: pointer to employee
process_employee_performance proc

    push ax
    push dx

    ; Take away ot and ph from hours worked
    mov ax, [bx].hours_worked
    sub ax, [bx].overtime_hours
    sub ax, [bx].holiday_hours

    jno hours_no_overflow  ; if number overflowed, set to 0
    xor ax, ax

hours_no_overflow:
    mov [bx].hours_worked, ax

    ; Calculate claimed pto
    mov ax, [bx].pto
    mov dx, [bx].monthly_leaves
    call min

    mov [bx].claimed_pto, ax

    pop ax
    pop dx
    ret

process_employee_performance endp