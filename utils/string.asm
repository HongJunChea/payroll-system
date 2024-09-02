; compare two strings
; Parameters
;   ds:si: pointer to string 1
;   es:di: pointer to string 2
;   cx: string length
; Returns
;   zf: 1 = same
;       0 = not same
compare_string proc

    repe cmpsb
    ret

compare_string endp


strcmp macro str1, str2, len

    push cx
    push si
    push di

    xor ch, ch
    mov cl, len
    lea si, str1
    lea di, str2
    call compare_string

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

