; gather string inputs. End the buffer with "$". Does not include "\n" and "\r".
; Ctrl + C terminates early and set dl = 1
; Params:
;   di: string buffer
;   ch: max number of chars, including "$"
; Returns:
;   cl: number of characters
;   dl: status code. (0 - ok, 1 - ctrl c)
input_string proc

    push ax
    xor cl, cl  ; set cl = 0

    dec ch      ; to offset the "$" length
    mov ah, 02h ; print signal

input_loop:
    input_char_no_echo

    ; if input = backspace
    cmp al, 8    ; \b
    je backspace

    ; if input = ctrl c
    cmp al, 3    ; ctrl c
    je ctrlc

    ; if input = \r
    cmp al, 13   ; \r
    je finish

    ; if input_length >= max_length - 1
    cmp cl, ch
    jae input_loop

    ; check within ascii of " " and "~"
    cmp al, " "
    jb input_loop
    cmp al, "~"
    ja input_loop

    stosb
    inc cl

    mov dl, al    ; echo entered char
    int 21h

    jmp input_loop

backspace:
    call delete_last_char
    dec cl
    dec di
    jmp input_loop

ctrlc:
    mov dl, 1

finish:
    mov dl, 10     ; print newline
    int 21h

    mov [di], "$"  ; terminates string
    mov dl, 0

    inc ch         ; restore ch
    pop ax
    ret

input_string endp


; A util for pausing and waiting for user input before proceeding
press_any_key_to_continue proc

    push ax
    push dx

    putc 10
    puts PRESS_ANY_KEY
    input_char_no_echo
    putc 10

    pop dx
    pop ax

press_any_key_to_continue endp

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
