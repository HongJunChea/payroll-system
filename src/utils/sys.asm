exit macro exit_code

    mov ah, 4ch
    mov al, exit_code
    int 21h

endm