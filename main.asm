.model big

.386  ; allow eax

.stack 100

.data
    val dw 100
    
.code
include utils/print.asm
include utils/io.asm

main proc
    mov ax, @data
    mov ds, ax

    mov ax, 100
    call print_num_unsigned

    exit 0
main endp

end main