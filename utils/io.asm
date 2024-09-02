exit macro exit_code

    mov ah, 4ch
    mov al, exit_code
    int 21h

endm


movdw macro src, dest

    push cx
    push si
    push di

    mov cx, 2
    lea si, src
    lea di, dest
    rep movsw

    pop di
    pop si
    pop cx

endm