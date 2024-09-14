.model big

.stack 100

.data
include inc/data.inc

.code
include inc/src.inc

main proc
    mov ax, @data
    mov ds, ax
    mov es, ax

    mov ah, 02h
    mov dl, var1
    int 21h

    mov ah, 4ch
    mov al, 0
    int 21h
main endp

end main