input_char macro

    mov ah, 01h
    int 21h

endm


input_char_no_echo macro 

    mov ah, 08h
    int 21h

endm


input_string macro

    push ax 

    mov ah, 0Ah
    int 21h

    pop ax

endm


scanc macro b_buffer

    push bx
    push ax

    input_char
    mov bl, al

    pop ax

    mov b_buffer, bl

    pop bx

endm


scann macro b_buffer

    push bx
    push ax

    input_char
    sub al, "0"
    mov bl, al

    pop ax

    mov b_buffer, bl

    pop bx

endm

scanc_no_echo macro b_buffer
    push ax

    input_char_no_echo
    mov b_buffer, al

    pop ax

endm



scans macro buffer

    push dx

    lea dx, buffer
    input_string

    pop dx

endm


; result will be in ax
.input_num_ten db 10
input_num proc

    push bx

    xor ax, ax
    xor bx, bx

    next_digit:

        scanc_no_echo bl

        cmp bl, 13 ; "\r"
        je stop

        ; if not between 0 - 9
        cmp bl, "0"
        jb next_digit
        cmp bl, "9"
        ja next_digit

        putc bl     ;

        mul .input_num_ten
        sub bl, "0"
        add ax, bx
        
        jmp next_digit

    stop:
        putc 10

    pop bx
    ret

input_num endp
