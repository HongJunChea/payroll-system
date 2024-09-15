; compare two strings
; Parameters
;   ds:si: pointer to string 1
;   es:di: pointer to string 2
;   cx: string length
; Returns
;   zf: 1 = same
;       0 = not same
compare_string_numbered proc

    push si
    push di

    repe cmpsb

    pop di
    pop si
    ret

compare_string_numbered endp


; compare two strings terminated with "$"
; Parameters
;   ds:si: pointer to string 1
;   es:di: pointer to string 2
; Returns
;   zf: 1 = same
;       0 = not same
compare_string proc

    push si
    push di
cmp_string_loop:
    cmp byte ptr [si], "$"
    je cmp_string_terminator
    cmp byte ptr [di], "$"
    je cmp_string_terminator

    cmpsb
    je cmp_string_loop

    pop di
    pop si
    ret

cmp_string_terminator:    ; check if str1[i] = str2[i] if either is "$".
    cmpsb

    pop di
    pop si
    ret

compare_string endp


; Convert string into
; Params
;   si: pointer to string
; Returns
;   ax: the number
;   dl: error code (0 - ok, 1 - invalid characters)
strtol proc

    xor ax, ax     ; set ax = 0

strtol_loop:       ; loop throught each characters
    mov dl, [si]   ; move each char to dl
    inc si

    cmp dl, "$"    ; terminate
    je strtol_finish

    push ax        ; is_digit uses al

    mov al, dl
    call is_digit  ; make sure is digits

    pop ax

    jne strtol_error

    push dx
    mul TEN_W      ; shift previous to the left by 10
    pop dx

    sub dl, "0"    ; convert ascii digit to number
    add al, dl     ; add onto ax

    jmp strtol_loop

strtol_finish:
    mov dl, 0  ; ok
    ret

strtol_error:
    mov dl, 1  ; error
    ret

strtol endp


; Convert string into float
; Params
;   si: pointer to string
; Returns
;   st(0): float
;   dl: error code (0 - ok, 1 - invalid characters)
strtof proc

    call strtol

    mov .tmp_word, ax
    fild .tmp_word

    jne process_fractional  ; if strtol error'd -> there's a character, can be "."

    ; no fractional, ex 9000
    ret

process_fractional:
    dec si
    cmp byte ptr [si], "."  ; check if the stopped point in on a decimal point
    jne strtof_error        ; if not, means its something else than "."

    inc si
    call strtol             ; read fractional part as integer
    jne strtof_error

    call count_digits

    mov .tmp_word, ax        ; load fractional part as integer
    fild .tmp_word

    push cx

    xor ch, ch
    mov cl, dl               ; divide by 10 ^ number of digits
    strtof_div_ten:
        fidiv TEN_W
        loop strtof_div_ten

    faddp st(1), st(0)  ; add integral and fractional part

    pop cx

    mov dl, 0
    ret

strtof_error:
    fpop
    mov dl, 1
    ret

strtof endp

;
; Macros
;

strcmp macro str1, str2

    push cx
    push si
    push di

    lea si, str1
    lea di, str2
    call compare_string

    pop di
    pop si
    pop cx

endm

strncmp macro str1, str2, len

    push cx
    push si
    push di

    xor ch, ch
    mov cl, len
    lea si, str1
    lea di, str2
    call compare_string_numbered

    pop di
    pop si
    pop cx

endm

; copy source string to dest
strcpy MACRO source, dest, len
    
    push cx
    push si
    push di

    mov cx, len
    lea si, source
    lea di, dest
    rep movsb

    pop di
    pop si
    pop cx

endm

