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


putsn macro string, len

    push cx
    push dx

    lea si, string
    mov cx, len
    call print_string_numbered

    pop dx
    pop cx

endm



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

    fist .tmp_word        ; load integral part of float
    mov ax, .tmp_word              
    call print_num_unsigned      ; print integral part

    putc "."
    
    fisub .tmp_word       ; remove integer part of float => 123.4567 -> 0.4567
    fimul .thousand  ; move decimal three space left => 0.4567 -> 456.7

    fistp .tmp_word       ; load integral part and clear stack
    mov ax, .tmp_word             
    call print_num_unsigned      ; print integral part   

    pop dx
    pop ax
    ret

print_float endp
