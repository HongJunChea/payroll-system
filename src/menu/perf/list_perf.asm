list_performance proc

    push bx

    puts LIST_PERFORMANCE_HEADER

    lea bx, employees

    xor ch, ch  ; clear ch for cl
    mov cl, .number_of_emps

    print_perfs:
        cmp [bx].filled_performance, 0
        je print_perfs_not_filled

        call print_emp_perf_row
        jmp print_perfs_continue

        print_perfs_not_filled:
            call print_emp_perf_inval_row

        print_perfs_continue:
            add bx, size employee
            loop print_perfs

    pop bx
    ret

list_performance endp



print_emp_perf_row proc

    push ax
    push cx
    push dx

    putsn [bx].emp_id EMP_ID_LEN  ; 5 char long

    putc_n " " 9  ; 6 + 3

    putsn_b [BX].emp_name [BX].emp_name_length

    mov cx, 18   ; header width
    sub cl, [bx].emp_name_length
    cmp cl, 0
    jle dont_pad_emp_name_2

    putc_n " " cx

dont_pad_emp_name_2:

    putfloat [BX].orp

    putc_n " " 9

    putnum [bx].hours_worked

    putc_n " " 12

    putnum [bx].overtime_hours

    putc_n " " 9

    putnum [bx].holiday_hours

    putc_n " " 9

    call calculate_total
    call print_float
    fstp st(0)  ; pop

    putc 10

    pop dx
    pop cx
    pop ax
    ret

print_emp_perf_row endp


print_emp_perf_inval_row proc

    push ax
    push cx
    push dx

    putsn [bx].emp_id EMP_ID_LEN  ; 5 char long

    putc_n " " 9  ; 6 + 3

    putsn_b [BX].emp_name [BX].emp_name_length

    mov cx, 18   ; header width
    sub cl, [bx].emp_name_length
    cmp cl, 0
    jle dont_pad_emp_name_3

    putc_n " " cx

dont_pad_emp_name_3:

    putfloat [BX].orp

    putc_n " " 9

    puts NA

    putc_n " " 13

    puts NA

    putc_n " " 9

    puts NA

    putc_n " " 9

    puts NA

    putc 10

    pop dx
    pop cx
    pop ax
    ret

print_emp_perf_inval_row endp