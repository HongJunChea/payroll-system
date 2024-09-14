; Check if an ascii is a number
; Params
;   dl: character
; Returns
;   zf: 1 - equals
;       0 - not equals
is_num proc

    cmp dl, "0"     ; if dl < "0"
    jb is_not_num
    cmp dl, "9"     ; if dl > "9"
    ja is_not_num
    cmp dl, dl      ; set zf = 0
    ret

is_not_num:
    ret

is_num endp