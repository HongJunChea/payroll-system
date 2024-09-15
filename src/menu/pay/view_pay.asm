; View employee full payroll summary in pages.
; Params
;   bx: pointer to employee
view_pay proc

    ; calculate before printing
    call calculate_total
    fpop

    puts EMP_PAY_HEADER
    puts BOLD_BORDER
    call print_pay_employee_details
    puts THIN_BORDER

    call press_any_key_to_continue

    puts THIN_BORDER
    call print_pay_details
    puts THIN_BORDER

    puts EMP_PAY_TOTAL
    putf payroll.total
    putc 10

    call press_any_key_to_continue
    ret

view_pay endp


; Print summary of employee details
; Params
;   bx: pointer to employee
print_pay_employee_details proc

    ; Row 1
    puts EMP_PAY_NAME
    puts [bx].emp_name

    putc_n " " 3

    puts EMP_PAY_ID
    puts [bx].emp_id

    putc 10

    ; Row 2
    puts EMP_PAY_JOB
    call print_job_type

    putc 10

    ; Row 3
    puts EMP_PAY_SOCSO
    mov al, [bx].has_socso
    call print_bool

    putc_n " " 3

    puts EMP_PAY_EPF
    mov al, [bx].has_epf
    call print_bool

    putc_n " " 3

    puts EMP_PAY_EIS
    mov al, [bx].has_eis
    call print_bool

    putc 10
    ret

print_pay_employee_details endp


move_right macro

    add dl, 18
    call set_cursor_pos

    putc "|"

    add dl, 1
    call set_cursor_pos

endm

; Print employee payroll details in tabular form
; Params
;   bx: pointer to employee
print_pay_details proc

    ; Header
    call get_cursor_pos
    puts EMP_PAY_EARN_HEADER

    move_right

    call EMP_PAY_DEDUC_HEADER

    ; Row 1
    call get_cursor_pos
    call print_pay_basic

    move_right

    call print_pay_socso
    putc 10

    ; Row 2
    call get_cursor_pos
    call print_pay_ot

    move_right

    call print_pay_epf
    putc 10

    ; Row 3
    call get_cursor_pos
    call print_pay_ph

    move_right

    call print_pay_eis
    putc 10

    ; Row 4
    call get_cursor_pos
    call print_pay_earn_subtotal

    move_right

    call print_pay_deduc_subtotal
    putc 10

    ret

print_pay_details endp


; Print employee basic salary.
; Position to print is row 1, left
; Params
;   payroll.basic
print_pay_basic proc

    putf payroll.basic
    ret

print_pay_basic endp


; Print employee overtime rate. Wont print if no overtime worked.
; Position to print is row 2, left
; Params
;   bx: pointer to employee
;   payroll.ot
print_pay_ot proc

    cmp [bx].overtime_hours, 0  ; if no overtime hours
    jbe skip

    putf payroll.ot

skip:
    ret

print_pay_ot endp


; Print employee public holiday rate. Wont print if no public holiday worked.
; Position to print is row 3, left
; Params
;   bx: pointer to employee
;   payroll.ph
print_pay_ph proc

    cmp [bx].holiday_hours, 0  ; if no public holiday hours
    jbe skip

    putf payroll.ph

skip:
    ret

print_pay_ph endp


; Print employee earning subtotal.
; Position to print is row 4, left
; Params
;   payroll.earn_total
print_pay_earn_subtotal proc

    putf payroll.earn_total
    ret

print_pay_earn_subtotal endp


; Print employee socso deductions. Wont print if no socso.
; Position to print is row 1, right
; Params
;   bx: pointer to employee
;   payroll.socso
print_pay_socso proc

    cmp [bx].has_socso, 0  ; if no socso
    je skip

    putf payroll.socso

skip:
    ret

print_pay_socso endp


; Print employee epf deductions. Wont print if no epf.
; Position to print is row 2, right
; Params
;   bx: pointer to employee
;   payroll.epf
print_pay_epf proc

    cmp [bx].has_epf, 0  ; if no epf
    je skip

    putf payroll.epf

skip:
    ret

print_pay_epf endp


; Print employee eis deductions. Wont print if no eis.
; Position to print is row 3, right
; Params
;   bx: pointer to employee
;   payroll.eis
print_pay_eis proc

    cmp [bx].has_eis, 0  ; if no eis
    je skip

    putf payroll.eis

skip:
    ret

print_pay_eis endp


; Print employee deductions subtotal.
; Position to print is row 4, right
; Params
;   payroll.deduc_total
print_pay_deduc_subtotal proc

    putf payroll.deduc_total
    ret

print_pay_deduc_subtotal endp


; Utility to print the text "Fulltime" or "Parttime" based on employee job type
; Params
;   bx: pointer to employee
print_job_type proc

    cmp [bx].job_type, 1
    je perf_job_pt
    cmp [bx].job_type, 2
    je perf_job_ft

    puts EMP_JOB_TYPE_INVALID_MSG
    ret

is_pt:
    puts EMP_PT_MSG
    ret

is_ft:
    puts EMP_FT_MSG
    ret

print_job_type endp
