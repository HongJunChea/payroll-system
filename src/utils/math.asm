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
    ; formula is: floor(log 10 (n) + 1)

    ; could be approximated and stored in a variable but eh
    fld1                 ; load 1.0
    fldl2t               ; load log 2 (10)
    fdivp st(1), st(0)   ; 1 / log 2 (10)

    mov .tmp_word, ax
    fild .tmp_word

    fyl2x               ; st(1) * log 2 (st(0))

    fld1                ; log 10 (n) + 1
    faddp st(1), st(0)

    fistp .tmp_word     ; floor and store result
    mov dl, byte ptr [.tmp_word]

    ret

count_digits endp
