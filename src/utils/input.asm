input_num proc

    push dx

    xor ax, ax

    .input_num_next_digit:
        input_char_no_echo

        cmp dl, 13 ; "\r"
        je .input_num_stop

        cmp dl, 8  ; "\b"

        ; if not between 0 - 9
        call
        ja .input_num_next_digit

        putc bl     ;

        mul TEN_B
        sub bl, "0"
        add ax, bx

        jmp .input_num_next_digit

    .input_num_stop:
        putc 10

    pop dx
    ret

input_num endp


;
; Macros
;
input_char macro

    mov ah, 01h
    int 21h

endm


input_char_no_echo macro 

    mov ah, 08h
    int 21h

endm


input_string macro

    mov ah, 0Ah
    int 21h

endm


getc macro b_buffer

    push bx
    push ax

    input_char
    mov bl, al

    pop ax

    mov b_buffer, bl

    pop bx

endm


getc_no_echo macro b_buffer

    push ax

    input_char_no_echo
    mov b_buffer, al

    pop ax

endm


getd macro b_buffer

    push bx
    push ax

    input_char
    sub al, "0"
    mov bl, al

    pop ax

    mov b_buffer, bl

    pop bx

endm


gets macro buffer

    push dx

    lea dx, buffer
    input_string

    pop dx

endm

