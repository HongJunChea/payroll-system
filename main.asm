.model big

.386  ; allow eax

.stack 100

.data
    include struct/employee.asm

    employee1 employee <, 10.00, 2000.00, 20, 0, 1, 1>
    
.code
include utils/print.asm
include utils/io.asm

main proc
    mov ax, @data
    mov ds, ax
    xor ax, ax

    mov al, employee1.pto
    call print_num_unsigned

    exit 0
main endp

end main