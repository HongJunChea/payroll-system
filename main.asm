.model big

.386  ; allow eax

.stack 100

.data
    include structs.inc
    include data.inc

    employees employee 20 DUP(<>)

.code
include utils.inc
include methods.inc
include ui.inc

main proc
    mov ax, @data
    mov ds, ax
    mov es, ax
    xor ax, ax  ; clear ax

    ; call login_menu
    
    ; putc 10

    call generate_emp_data
; 
    lea bx, employees
    mov si, 0
    mov cx, 2

print_all_employee:
    putsn_b [BX][SI].emp_name [BX][SI].emp_name_length

    putc " "

    putfloat [BX][SI].orp

    putc " "

    putnum_b [bx][si].pto

    putc " "

    putnum_b [bx][si].has_epf

    putc " "

    putnum_b [bx][si].has_socso

    putc " "

    putnum_b [bx][si].has_eis

    putc 10

    add si, size employee

    loop print_all_employee

    exit 0

main endp

end main