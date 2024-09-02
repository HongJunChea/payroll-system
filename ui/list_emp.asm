list_all_employee PROC
    
    push bx

    lea bx, employees

    xor ch, ch  ; clear ch for cl
    mov cl, number_of_employees

    list_all_employee_print_all:
        call print_emp_row
        add bx, size employee
        loop list_all_employee_print_all
    
    pop bx
    ret

list_all_employee ENDP


; print employee info in a row
; Params:
;   bx: pointer to employee
print_emp_row proc

    putsn [bx].emp_id emp_id_length

    putc " "
    putc " "

    putsn_b [BX].emp_name [BX].emp_name_length

    putc " "
    putc " "

    putfloat [BX].orp

    putc " "
    putc " "

    putnum_b [bx].pto

    putc " "
    putc " "

    putnum_b [bx].has_epf

    putc " "
    putc " "

    putnum_b [bx].has_socso

    putc " "
    putc " "

    putnum_b [bx].has_eis

    putc 10

    ret

print_emp_row endp