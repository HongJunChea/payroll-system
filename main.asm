.model small

.386  ; allow eax

.stack 100

.data
    val dd 123.45
    
.code
include utils/print.asm
include utils/io.asm

main proc
    mov ax, @data
    mov ds, ax

    fld val
    call print_float

    exit 0
main endp

end main