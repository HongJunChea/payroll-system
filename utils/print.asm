print macro
    push ax

    mov ah, 02h
    int 21h

    pop ax

endm


print_string macro
    push ax

    mov ah, 09h
    int 21h

    pop ax

endm


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


putnum macro u_num

    push ax

    mov ax, u_num
    call print_num_unsigned

    pop ax

endm


putnum_b macro u_num_b

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

    lea si, string
    mov cx, len
    call print_string_numbered

    pop si
    pop dx
    pop cx

endm


putsn_b macro string, len_b

    push cx
    push dx
    push si

    xor cx, cx ; clear cx

    lea si, string
    mov cl, len_b
    call print_string_numbered

    pop si
    pop dx
    pop cx

endm


putfloat macro float

    fld float
    call print_float

endm


putc_n macro char, number_of_times

    mov dl, char
    mov cx, number_of_times
    call print_char_numbered

endm


; dl: char
; cx: number_of_times
print_char_numbered proc

    mov ah, 02h

    putc_n_loop:
        int 21h
        loop putc_n_loop

    ret

print_char_numbered endp


; bool in al
print_bool proc

    cmp al, 0
    je putc_bool_false

    putc_bool_true:
        putc "Y"
        ret

    putc_bool_false:
        putc "N"
        ret

print_bool endp


; Parameters
;   cx: string length
;   si: string pointer
print_string_numbered proc

    print_string_numbered_loop:
        lodsb
        putc al
        loop print_string_numbered_loop

    ret

print_string_numbered endp  



print_num_unsigned proc near
    push ax 
    push cx
    push dx

    xor cx, cx      ; set cx = 0

    .divide:
        xor dx, dx  ; clear remainder

        div .ten

        push dx     ; push remainder to print
        inc cx

        test ax, ax ; if ax > 0
        jnz .divide ; continue

    .print_all:
        pop dx 
        add dx, "0"
        print

        loop .print_all

    pop dx
    pop cx
    pop ax
    ret

print_num_unsigned endp


print_binary_word proc near
    push ax
    push cx
    push dx

    mov cx, 16      ; 16 bits in a word

    .loop:
        xor dx, dx      ; set dx = 0

        test ax, 32768  ; if ax & 2^15
        jz .print       ; print 0
        mov dx, 1       ; else print 1

    .print:
        print

        shl ax, 1
        loop .loop

    pop dx
    pop cx
    pop ax
    ret

print_binary_word endp


; Params
;   st(0): float to be printed
; Returns
;   none
print_float proc near
    push ax
    push dx

    fld st(0)  ; duplicates it

    fist .tmp_word        ; load integral part of float
    mov ax, .tmp_word              
    call print_num_unsigned      ; print integral part

    putc "."
    
    fisub .tmp_word       ; remove integer part of float => 123.4567 -> 0.4567
    fimul .hundred  ; move decimal three space left => 0.4567 -> 456.7

    fistp .tmp_word       ; load integral part
    mov ax, .tmp_word             
    call print_num_unsigned      ; print integral part   

    pop dx
    pop ax
    ret

print_float endp
