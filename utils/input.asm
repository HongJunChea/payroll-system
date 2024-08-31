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
input_num proc

    push bx

    xor ax, ax
    xor bx, bx

    .input_num_next_digit:

        scanc_no_echo bl

        cmp bl, 13 ; "\r"
        je .input_num_stop

        ; if not between 0 - 9
        cmp bl, "0"
        jb .input_num_next_digit
        cmp bl, "9"
        ja .input_num_next_digit

        putc bl     ;

        mul .ten_b
        sub bl, "0"
        add ax, bx
        
        jmp .input_num_next_digit

    .input_num_stop:
        putc 10

    pop bx
    ret

input_num endp
