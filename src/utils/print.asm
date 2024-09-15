; Invoke the DOS print char interrupt.
; Print out a single character
; Params
;   dl: ascii character
print proc
    push ax

    mov ah, 02h
    int 21h

    pop ax
    ret

print endp


; Invoke the DOS print buffer interrupt.
; Print "$" terminated string
; Params
;   dx: pointer to the string
print_string proc
    push ax

    mov ah, 09h
    int 21h

    pop ax
    ret

print_string endp


putc macro char
    push dx

    mov dl, char
    call print

    pop dx

endm


puts macro string
    push dx

    lea dx, string
    call print_string

    pop dx

endm


; Repeat print a character for cx times
; Params
;   dl: char
;   cx: number_of_times
print_char_repeat proc

    mov ah, 02h

print_char_repeat_loop:
    int 21h
    loop print_char_repeat_loop

    ret

print_char_repeat endp


putc_n macro char, number_of_times

    mov dl, char
    mov cx, number_of_times
    call print_char_repeat

endm


; Print out a boolean value as Y or N
; Params
;   al: boolean value
print_bool proc

    cmp al, 0
    je print_bool_is_false

    ; is true
    putc "Y"
    ret

print_bool_is_false:
    putc "N"
    ret

print_bool endp


; Print string without terminator given length
; Params
;   si: string pointer
;   cx: string length
printn_string proc

printn_string_loop:
    lodsb
    putc al
    loop printn_string_loop

    ret

printn_string endp


putsn macro string, len

    push cx
    push dx
    push si

    xor ch, ch
    mov cl, len
    lea si, string
    call printn_string

    pop si
    pop dx
    pop cx

endm


; Print the number in ax
; Params
;   ax: number
print_num proc near
    push ax
    push cx
    push dx

    xor cx, cx      ; set cx = 0

    print_num_divide:
        xor dx, dx  ; clear remainder

        div TEN_W

        push dx     ; push remainder to print
        inc cx

        test ax, ax ; if ax > 0
        jnz print_num_divide ; continue

    print_num_loop:
        pop dx
        add dx, "0"
        call print

        loop print_num_loop

    pop dx
    pop cx
    pop ax
    ret

print_num endp


putn macro u_num

    push ax

    mov ax, u_num
    call print_num

    pop ax

endm


putn_b macro u_num_b

    push ax

    xor ax, ax  ; clear ax
    mov al, u_num_b
    call print_num

    pop ax

endm


; Prints float currently on the top of the stack.
; *No side effects
; Params
;   st(0): float to be printed
; Returns
;   none
print_float proc near
    push ax
    push dx

    fld st(0)                ; duplicates top float

    fist .tmp_word           ; load integral part of float
    mov ax, .tmp_word
    call print_num           ; print integral part

    putc "."                 ; print decimal seperator

    fisub .tmp_word          ; remove integer part of float => 123.4567 -> 0.4567
    fimul HUNDRED_W          ; move decimal point two space left => 0.4567 -> 456.7

    fistp .tmp_word          ; load integral part
    mov ax, .tmp_word
    call print_num           ; print integral part

    pop dx
    pop ax
    ret

print_float endp


putf macro float

    fld float
    call print_float
    fpop

endm


; overrides last character input with whitespace.
; Works by moving cursor back 1 character, printing whitespace, and moving cursor back 1 character again.
delete_last_char proc

    push dx

    mov ah, 02h

    mov dl, 8  ; \b
    int 21h
    mov dl, " "
    int 21h
    mov dl, 8  ; \b
    int 21h

    pop dx

delete_last_char endp







