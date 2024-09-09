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