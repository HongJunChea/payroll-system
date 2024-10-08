input_char macro

    mov ah, 01h
    int 21h

endm


input_char_no_echo macro

    mov ah, 08h
    int 21h

endm


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

input_string_loop:
    input_char_no_echo

    ; if input = input_string_backspace
    cmp al, 8    ; \b
    je input_string_backspace

    ; if input = ctrl c
    cmp al, 3    ; ctrl c
    je input_string_ctrlc

    ; if input = \r
    cmp al, 13   ; \r
    je input_string_finish

    ; if input_length >= max_length - 1
    cmp cl, ch
    jae input_string_loop

    ; check within ascii of " " and "~"
    call is_printable
    jne input_string_loop

    stosb
    inc cl

    mov ah, 02h
    mov dl, al    ; echo entered char
    int 21h

    jmp input_string_loop

input_string_backspace:
    cmp cl, 0     ; make sure have characters to backspace
    jbe input_string_loop

    puts DELETE_LAST_CHAR
    dec cl
    dec di
    jmp input_string_loop

input_string_ctrlc:
    mov ah, 02h
    mov dl, 10     ; print newline
    int 21h

    mov byte ptr [di], "$"  ; terminates string
    mov dl, 1      ; leave bad status

    inc ch         ; restore ch
    pop ax
    ret

input_string_finish:
    mov ah, 02h
    mov dl, 10     ; print newline
    int 21h

    mov byte ptr [di], "$"  ; terminates string
    mov dl, 0      ; leave ok status

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
    ret

press_any_key_to_continue endp
