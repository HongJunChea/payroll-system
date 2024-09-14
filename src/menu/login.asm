; Prompt the user to login
; Params:
;
; Returns:
;   zf: 1 - login
;       0 - failed
login_menu proc
	puts LOGIN_MSG

ask_id:    ; loop when fail login
    puts PROMPT_PASS

    mov di, .input_pass
    mov ch, length .input_pass
    call input_password

	strcmp .input_pass .correct_pass
	putc 10
	je login_success

    ; invalid password
    puts INVALID_PASS
    jmp ask_id

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
input_password proc

    push ax
    xor cl, cl  ; set cl = 0
    dec ch      ; to offset the "$" length

input_loop:
    input_char_no_echo

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
    putc "*"

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

input_password endp


