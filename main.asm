.model big

.386  ; allow eax

.stack 100

.data
    include structs.inc
    include data.inc

    employees employee 20 DUP(<,,,,,,,>)

.code
include utils.inc
include methods.inc
include ui.inc

main proc
    mov ax, @data
    mov ds, ax
    mov es, ax
    xor ax, ax  ; clear ax

    call login_menu
    
    putc 10

    mov bx, offset employees
    call main_menu

    putc 10

    exit 0

main endp

end main