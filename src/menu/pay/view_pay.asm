view_pay proc

    puts EMP_PERF_HEADER
    puts BOLD_BORDER

    call print_perf_dets

    puts THIN_BORDER

    puts LS_EMPS_PERF_HEADER
    call print_emp_perf_row

    puts THIN_BORDER

    putc 10
    puts PRESS_ANY_KEY
    input_char_no_echo
    putc 10

    call print_perf_earnings

    puts THIN_BORDER

    call print_perf_deducts

    puts THIN_BORDER

    call print_perf_total

    putc 10

    puts PRESS_ANY_KEY
    input_char_no_echo

    putc 10

    ret

view_pay endp


print_perf_dets proc

    puts EMP_PERF_NAME
    putsn_b [BX].emp_name [BX].emp_name_length

    putc_n " " 3

    puts EMP_PERF_ID
    putsn [bx].emp_id EMP_ID_LEN

    putc 10

    puts EMP_PERF_JOB
    call print_job_type

    putc 10

    mov al, [bx].has_socso
    puts EMP_PERF_SOCSO
    call print_bool

    putc_n " " 3

    mov al, [bx].has_epf
    puts EMP_PERF_EPF
    call print_bool

    putc_n " " 3

    mov al, [bx].has_eis
    puts EMP_PERF_EIS
    call print_bool

    putc 10
    ret

print_perf_dets endp


print_perf_earnings proc

    puts EMP_PERF_EARN_HEADER

    call calculate_basic
    fst .emp_perf_basic_tmp

        puts EMP_PERF_BASIC
        call print_float

        putc 10
    ; skip_calc_basic:
    call calculate_ot
    fst .emp_perf_basic_tmp

    cmp [bx].overtime_hours, 0
    jbe skip_calc_ot

        puts EMP_PERF_OT
        call print_float

        putc 10
    skip_calc_ot:
    call calculate_ph
    fst .emp_perf_ph_tmp

    cmp [bx].holiday_hours, 0
    jbe skip_calc_ph

        puts EMP_PERF_PH
        call print_float

        putc 10
    skip_calc_ph:
    mov cx, 3
    call calculate_subtotal

    puts EMP_PERF_EARN_TOTAL
    call print_float

    fstp .emp_perf_earn_total_tmp

    putc 10
    ret

print_perf_earnings endp


print_perf_deducts proc

    puts EMP_PERF_DEDUC_HEADER

    call calculate_socso
    fst .emp_perf_socso_tmp

    cmp [bx].has_socso, 0
    je skip_calc_socso

        puts EMP_PERF_DEDUC_SOCSO
        call print_float

        putc 10
    skip_calc_socso:
    call calculate_epf
    fst .emp_perf_epf_tmp

    cmp [bx].has_epf, 0
    je skip_calc_epf

        puts EMP_PERF_DEDUC_EPF
        call print_float

        putc 10
    skip_calc_epf:
    call calculate_eis
    fst .emp_perf_eis_tmp

    cmp [bx].has_eis, 0
    je skip_calc_eis

        puts EMP_PERF_DEDUC_EIS
        call print_float

        putc 10
    skip_calc_eis:
    mov cx, 3
    call calculate_subtotal

    puts EMP_PERF_DEDUC_TOTAL
    call print_float

    fstp .emp_perf_ded_total_tmp

    putc 10
    ret

print_perf_deducts endp


print_perf_total proc

    puts EMP_PERF_EARN_TOTAL
    fld .emp_perf_earn_total_tmp
    call print_float

    putc 10

    puts EMP_PERF_DEDUC_TOTAL
    fld .emp_perf_ded_total_tmp
    call print_float

    putc 10
    putc 10

    puts EMP_PERF_NET_TOTAL
    fsubp st(1), st(0)
    call print_float

    putc 10
    ret

print_perf_total endp




print_job_type proc

    cmp [bx].job_type, 1
    je perf_job_pt
    cmp [bx].job_type, 2
    je perf_job_ft

    puts EMPLOYEE_JOB_TYPE_INVALID_MESSAGE
    ret

perf_job_pt:
    puts EMP_PERF_PT
    ret

perf_job_ft:
    puts EMP_PERF_FT
    ret

print_job_type endp
