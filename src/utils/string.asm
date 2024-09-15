; compare two strings
; Parameters
;   ds:si: pointer to string 1
;   es:di: pointer to string 2
;   cx: string length
; Returns
;   zf: 1 = same
;       0 = not same
compare_string_numbered proc

    repe cmpsb
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

cmp_loop:
    cmp [si], "$"
    je terminator
    cmp [di], "$"
    je terminator

    cmpsb
    je cmp_loop
    ret

terminator:    ; check if str1[i] = str2[i] if either is "$".
    cmpsb
    ret

compare_string endp


; Convert string into
; Params
;   si: pointer to string
; Returns
;   ax: the number
;   dl: error code (0 - ok, 1 - invalid characters)
strtol proc

    push ax
    xor ax, ax     ; set ax = 0
    xor dl, dl     ; set dl = 0

read_loop:
    mov dl, [si]   ; move each char to dl
    inc si

    cmp dl, "$"    ; terminate
    je finish

    call is_digit  ; make sure is digits
    jne error

    mul ten_b      ; shift previous to the left by 10

    sub dl, "0"    ; convert ascii digit to number
    add al, dl     ; add onto ax

    jmp read_loop

finish:
    pop ax
    mov dl, 0  ; ok
    ret

error:
    pop ax
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
    cmp [si], "."       ; check if the stopped point in on a decimal point
    jne error           ; if not, means its something else than "."

    inc si
    call strtol         ; read fractional part as integer
    jne error

    push cx

    call count_digits

    mov .tmp_word, ax   ; load fractional part as integer
    fild .tmp_word

    xor ch, ch
    mov cl, dl          ; divide by 10 ^ number of digits
div_10:
    fidiv TEN_W
    loop div_10

    faddp st(1), st(0)  ; add integral and fractional part

    pop cx

    mov dl, 0
    ret

error:
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

