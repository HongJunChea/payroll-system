view_emp_perf proc

    puts EMP_PERF_HEADER
    puts BOLD_BORDER

    puts EMP_PERF_NAME
    putsn_b [BX].emp_name [BX].emp_name_length

    putc_n " " 3

    puts EMP_PERF_ID
    putsn [bx].emp_id emp_id_length

    putc 10

    puts EMP_PERF_JOB
    call print_job_type

    putc 10

    mov al, [bx].has_sosco
    puts EMP_PERF_SOCSO
    call print_bool

    putc_n " " 3

    mov al, [bx].has_epf
    puts EMP_PERF_EPF
    call print_bool

    putc_n " " 3

    mov al, [bx].has_eif
    puts EMP_PERF_EIS
    call print_bool

    putc 10

    puts THIN_BORDER

    puts LS_EMPS_PERF_HEADER
    call print_emp_perf_row

    puts THIN_BORDER

    call print_perf_earnings

    puts THIN_BORDER

    call print_perf_deducts

    puts THIN_BORDER

    call print_perf_total

    putc 10

    puts PRESS_ANY_KEY_CONTINUE
    input_char_no_echo

    putc 10

    ret

view_emp_perf endp


print_perf_earnings proc

    puts EMP_PERF_EARN_HEADER

    puts EMP_PERF_BASIC
    call calculate_basic


    putc 10

    puts EMP_PERF_OT


    putc 10

    puts EMP_PERF_PH


    putc 10

    puts EMP_PERF_EARN_TOTAL


    putc 10
    ret

print_perf_earnings endp


print_perf_deducts proc

    puts EMP_PERF_DEDUC_HEADER

    putc 10
    ret

print_perf_deducts endp


print_perf_total proc

    puts EMP_PERF_EARN_TOTAL

    puts EMP_PERF_DEDUC_TOTAL

    puts EMP_PERF_NET_TOTAL

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
