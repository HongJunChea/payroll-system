; Invoke the DOS print char interrupt.
; Print out a single character
; Params
;   dl: ascii character
print proc
    push ax

    mov ah, 02h
    int 21h

    pop ax

print endp


; Invoke the DOS print buffer interrupt.
; Print "$" terminated string
; Params
;   dx: pointer to the string
print_string macro
    push ax

    mov ah, 09h
    int 21h

    pop ax

endm


; Repeat print a character for cx times
; Params
;   dl: char
;   cx: number_of_times
print_char_repeat proc

    mov ah, 02h

print_loop:
    int 21h
    loop print_loop

    ret

print_char_repeat endp


; Print out a boolean value as Y or N
; Params
;   al: boolean value
print_bool proc

    cmp al, 0
    je is_false

    ; is true
    putc "Y"
    ret

is_false:
    putc "N"
    ret

print_bool endp


; Print string without terminator given length
; Params
;   si: string pointer
;   cx: string length
printn_string proc

print_loop:
    lodsb
    putc al
    loop print_loop

    ret

printn_string endp


; Print the number in ax
; Params
;   ax: number
print_num proc near
    push ax
    push cx
    push dx

    xor cx, cx      ; set cx = 0

    divide:
        xor dx, dx  ; clear remainder

        div TEN_W

        push dx     ; push remainder to print
        inc cx

        test ax, ax ; if ax > 0
        jnz .divide ; continue

    print_loop:
        pop dx
        add dx, "0"
        call print

        loop .print_loop

    pop dx
    pop cx
    pop ax
    ret

print_num endp


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
    call print_num_unsigned  ; print integral part

    putc "."                 ; print decimal seperator

    fisub .tmp_word          ; remove integer part of float => 123.4567 -> 0.4567
    fimul HUNDRED_W           ; move decimal point two space left => 0.4567 -> 456.7

    fistp .tmp_word          ; load integral part
    mov ax, .tmp_word
    call print_num_unsigned  ; print integral part

    pop dx
    pop ax
    ret

print_float endp


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


;
; Macros
;
putc macro char
    push dx

    mov dl, char
    print

    pop dx

endm


puts macro string 
    push dx

    lea dx, string
    print_string

    pop dx

endm


putn macro u_num

    push ax

    mov ax, u_num
    call print_num_unsigned

    pop ax

endm


putn_b macro u_num_b

    push ax

    xor ax, ax  ; clear ax
    mov al, u_num_b
    call print_num_unsigned

    pop ax

endm


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


putc_n macro char, number_of_times

    mov dl, char
    mov cx, number_of_times
    call print_char_repeat

endm


putf macro float

    fld float
    call print_float
    fpop

endm
