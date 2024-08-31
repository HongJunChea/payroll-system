
; compare two strings
; Parameters
;   ds:si: pointer to string 1
;   es:di: pointer to string 2
;   cx: string length
; Returns
;   al: boolean
compare_string proc

    xor al, al

    repe cmpsb
    jnz not_equal

    mov al, 1
    ret

not_equal:
    mov al, 0
    ret

compare_string endp



strcmp macro str1, str2, len

    push si
    push di

    xor cx, cx
    mov cl, len
    lea si, str1
    lea di, str2
    call compare_string

    pop di
    pop si

endm

