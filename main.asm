.model big

.386  ; allow eax

.stack 100

.data
    include data/epf.asm

    val dd 5000.10

.code
include utils/print.asm
include utils/io.asm
include salary/epf.asm

main proc
    mov ax, @data
    mov ds, ax

    fld val
    call lookup_epf

    putnum bx
    putc 10
    putnum cx

    exit 0
main endp

end main