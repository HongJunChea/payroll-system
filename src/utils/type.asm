; Check if an ascii is a number
; Params
;   al: character
; Returns
;   zf: 1 - equals
;       0 - not equals
is_digit proc

    cmp al, "0"     ; if dl < "0"
    jb is_not_digit
    cmp al, "9"     ; if dl > "9"
    ja is_not_digit
    cmp al, al      ; set zf = 1
    ret

is_not_digit:
    ret

is_digit endp


; Check if an ascii is a printable character. ASCII of " " to "~"
; Params
;   al: character
; Returns
;   zf: 1 - equals
;       0 - not equals
is_printable proc

    cmp al, " "
    jb is_not_printable
    cmp al, "~"
    ja is_not_printable
    cmp al, al          ; set zf = 1
    ret

is_not_printable:
    ret

is_printable endp
