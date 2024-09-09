; Get the min of
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
