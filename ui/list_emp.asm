ls_emps PROC
    
    push bx

    puts LS_EMPS_HEADER

    lea bx, employees

    xor ch, ch  ; clear ch for cl
    mov cl, number_of_employees

    ls_emps_print_all:
        call print_emp_row
        add bx, size employee
        loop ls_emps_print_all
    
    pop bx
    ret

ls_emps ENDP


; print employee info in a row
; Params:
;   bx: pointer to employee
print_emp_row proc

    push ax
    push cx
    push dx

    putsn [bx].emp_id emp_id_length  ; 5 char long
   
    putc_n " " 9  ; 6 + 3

    putsn_b [BX].emp_name [BX].emp_name_length
    
    mov cx, 18   ; header width
    sub cl, [bx].emp_name_length
    cmp cl, 0
    jle dont_pad_emp_name

    putc_n " " cx

dont_pad_emp_name:

    putfloat [BX].orp

    putc_n " " 9

    putnum [bx].pto

    putc "h"
    putc "r"

    putc_n " " 3

    mov al, [bx].has_epf
    call print_bool
    
    putc_n " " 5

    mov al, [bx].has_socso
    call print_bool

    putc_n " " 7

    mov al, [bx].has_eis
    call print_bool

    putc 10

    pop dx
    pop cx
    pop ax
    ret

print_emp_row endp


ls_emps_perf proc

    push bx

    puts LS_EMPS_PERF_HEADER

    lea bx, employees

    xor ch, ch  ; clear ch for cl
    mov cl, number_of_employees

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

ls_emps_perf endp



print_emp_perf_row proc

    push ax
    push cx
    push dx

    putsn [bx].emp_id emp_id_length  ; 5 char long

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

    call calculate_pay
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

    putsn [bx].emp_id emp_id_length  ; 5 char long

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
