.model big

.386  ; allow eax

.stack 100

.data
    val dd 2400.10
    
.code
include utils/print.asm
include utils/io.asm
include salary/epf.asm

main proc
    mov ax, @data
    mov ds, ax

    fld val
    call lookup_epf

    mov ax, bx
    call print_num_unsigned

    mov dl, 10
    print

    mov ax, cx
    call print_num_unsigned

    exit 0
main endp

end main