; gather string inputs. End the buffer with "$". Does not include "\n" and "\r"
; Params:
;   di: string buffer
;   ch: max number of chars, including "$"
; Returns:
;   cl: number of characters
input_text proc

    push ax
    xor cl, cl  ; set cl = 0
    dec ch      ; to offset the "$" length

input_loop:
    input_char

    cmp al, 8    ; \b
    je backspace

    cmp al, 13   ; \r
    je finish

    cmp cl, ch   ; if input_length >= max_length - 1
    jae input_loop

    ; check within ascii of " " and "~"
    cmp al, " "
    jb input_loop
    cmp al, "~"
    ja input_loop

    stosb
    inc cl
    putc al

backspace:
    putc 8
    dec cl
    dec di
    jmp input_loop

finish:
    mov [di], "$"

    inc ch     ; restore ch
    pop ax
    ret

input_text endp


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


; not good lol
; input_string macro
;
;     mov ah, 0Ah
;     int 21h
;
; endm


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

