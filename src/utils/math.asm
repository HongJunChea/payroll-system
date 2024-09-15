; Get the min of two values
; Params
;   ax: the first value
;   dx: the second value
; Returns
;   ax: the min value
min proc

    cmp ax, dx
    jb min_is_dx
    ret

min_is_dx:
    mov ax, dx
    ret

min endp


; Calculate the number of digits of a number
; Params
;   ax: number
; Returns
;   dl: number of digits
count_digits proc

    ; counts digit using change of base: log a (b) = log c (b) / log c (a)
    ; formula is: floor(log 10 (n)) + 1
    fld INVLOG2T

    mov .tmp_word, ax
    fild .tmp_word

    fyl2x               ; st(1) * log 2 (st(0))

    fistp .tmp_word     ; floor and store result
    mov dl, byte ptr [.tmp_word]
    inc dl              ; + 1

    ret

count_digits endp
