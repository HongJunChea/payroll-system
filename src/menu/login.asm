; Prompt the user to login
; Params:
;
; Returns:
;   zf: 0 - login
;       1 - failed
login_menu proc
	puts LOGIN_MSG

login_ask_id:    ; loop when fail login
    puts PROMPT_PASS

    lea di, .input_pass
    mov ch, length .input_pass

    call input_password
    cmp dl, 1            ; check ctrl + c exit
    je login_failure

	strcmp .input_pass .correct_pass
	je login_success

    ; invalid password
    puts INVALID_PASS
    jmp login_ask_id

login_failure:
    test dl, dl   ; set zf = 0
    ret

login_success:
    puts VALID_PASS
    ret

login_menu endp


; gather string inputs while not echoing text typed. Does not include "\n" and "\r"
; Params:
;   di: string buffer
;   ch: max number of chars, including "$"
; Returns:
;   cl: number of characters
;   dl: status code. (0 - ok, 1 - ctrl c)
; See input_string
input_password proc

    push ax
    xor cl, cl  ; set cl = 0

    dec ch      ; to offset the "$" length

input_password_loop:
    input_char_no_echo

    ; if input = input_string_backspace
    cmp al, 8    ; \b
    je password_backspace

    ; if input = ctrl c
    cmp al, 3    ; ctrl c
    je input_string_ctrlc

    ; if input = \r
    cmp al, 13   ; \r
    je password_finish

    ; if input_length >= max_length - 1
    cmp cl, ch
    jae input_password_loop

    ; check within ascii of " " and "~"
    call is_printable
    jne input_password_loop

    stosb
    inc cl

    mov ah, 02h
    mov dl, "*"
    int 21h
    
    jmp input_password_loop

password_backspace:
    cmp cl, 0     ; make sure have characters to backspace
    jbe input_password_loop

    call delete_last_char
    dec cl
    dec di
    jmp input_password_loop

password_ctrlc:
    mov dl, 1

password_finish:
    mov ah, 02h
    mov dl, 10    ; print newline
    int 21h

    mov byte ptr [di], "$"  ; terminates string
    mov dl, 0     ; leave ok status

    inc ch        ; restore ch
    pop ax
    ret

input_password endp


