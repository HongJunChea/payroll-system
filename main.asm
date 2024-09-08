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

    call generate_emp_data

    call login_menu
    
    call main_menu

    exit 0

main endp

end main