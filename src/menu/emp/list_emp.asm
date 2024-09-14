ls_emps PROC
    
    push bx

    puts LS_EMPS_HEADER

    lea bx, employees

    xor ch, ch  ; clear ch for cl
    mov cl, .number_of_emps

    ls_emps_print_all:
        call print_emp_row
        add bx, size employee
        loop ls_emps_print_all

    puts PRESS_ANY_KEY
    input_char_no_echo

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

    putsn [bx].emp_id EMP_ID_LEN  ; 5 char long
   
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

