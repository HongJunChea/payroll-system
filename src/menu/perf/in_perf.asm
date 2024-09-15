; Set the monthly performance for a employee
; Parameters
;	bx: pointer to the employee
set_performance proc

    cmp [bx].job_type, 2
    je is_ft

    call prompt_performance_hours
    jmp continue

is_ft:
    call prompt_performance_days

continue:

    call prompt_performance_leaves
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

input_loop:
    puts PROMPT_HOURS_WORKED

    lea di, .input_buffer
    mov ch, length .input_buffer
    call input_string

    lea si, .input_buffer
    call strtol

    cmp dl, 0
    je no_error

    puts INVALID_VALUE_MSG
    jmp input_loop

no_error:
    mov [bx].pto, ax
    ret

prompt_performance_hours endp


; Prompt user to enter the number of days worked for full time employee
; Params
;   bx: pointer to the employee
prompt_performance_days proc

input_loop:
    puts PROMPT_DAYS_WORKED

    lea di, .input_buffer
    mov ch, length .input_buffer
    call input_string

    lea si, .input_buffer
    call strtol

    cmp dl, 0
    je no_error

    puts INVALID_VALUE_MSG
    jmp input_loop

no_error:
    mul EIGHT_B
    mov [bx].pto, ax
    ret

prompt_performance_days endp


; Prompt user to enter the number of days of leaves claimed for employee
; Params
;   bx: pointer to the employee
prompt_performance_leaves proc

input_loop:
    puts PROMPT_LEAVES

    lea di, .input_buffer
    mov ch, length .input_buffer
    call input_string

    lea si, .input_buffer
    call strtol

    cmp dl, 0
    je no_error

    puts INVALID_VALUE_MSG
    jmp input_loop

no_error:
    mul EIGHT_B
    mov [bx].pto, ax
    ret

prompt_performance_leaves endp


; Prompt user to enter the number of overtime hours worked for employee
; Params
;   bx: pointer to the employee
prompt_performance_ot proc

input_loop:
    puts PROMPT_OT

    lea di, .input_buffer
    mov ch, length .input_buffer
    call input_string

    lea si, .input_buffer
    call strtol

    cmp dl, 0
    je no_error

    puts INVALID_VALUE_MSG
    jmp input_loop

no_error:
    mov [bx].pto, ax
    ret

prompt_performance_ot endp


; Prompt user to enter the number of public holiday hours worked for employee
; Params
;   bx: pointer to the employee
prompt_performance_ph proc

input_loop:
    puts PROMPT_PH

    lea di, .input_buffer
    mov ch, length .input_buffer
    call input_string

    lea si, .input_buffer
    call strtol

    cmp dl, 0
    je no_error

    puts INVALID_VALUE_MSG
    jmp input_loop

no_error:
    mov [bx].pto, ax
    ret

prompt_performance_ph endp


; Process and calculate employee hours after entering
; Do
;   - take away ot and ph hours from hours worked
;   - calculate claimed pto
;   - add claimed pto onto hours worked
; Params
;   bx: pointer to employee
process_employee_performance proc

    push ax
    push dx

    ; Take away ot and ph from hours worked
    mov ax, [bx].hours_worked
    sub ax, [bx].overtime_hours
    sub ax, [bx].holiday_hours

    jno no_overflow  ; if number overflowed, set to 0
    xor ax, ax

no_overflow:
    mov [bx].hours_worked, ax

    ; Calculate claimed pto
    mov ax, [bx].pto
    mov dx, [bx].monthly_leaves
    call min

    mov [bx].claimed_pto, ax

    ; Add claimed pto onto hours worked
    mov ax, [bx].hours_worked
    add ax, [bx].claimed_pto
    mov [bx].hours_worked, ax

    pop ax
    pop dx
    ret

process_employee_performance endp