.model big

.386

.stack 100

.data
    include inc/data.inc
    employees employee 20 DUP(<>)

.code
include inc/src.inc

main proc
    mov ax, @data
    mov ds, ax
    mov es, ax

    call generate_emp_data

    call login_menu
    jne finish

    call clear_screen

    call main_menu

finish:
    exit 0

main endp

end main