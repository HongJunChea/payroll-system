; Lookup and calculate epf contribution from table
; *No side effects
; extra note: salary maximum 546125 due to 12% exceeding word size, can be rewritten to use ebx and ecx
; Params
;   st(0): current salary
; Returns
;   st(0): employer payable
;   st(1): employee payable
lookup_eis proc

    ficom THIRTY_W
    store_fpu_flags
    ja eis_above30

    ; 0 - 30
    fld EIS_B30[4]
    fld EIS_B30[0]
    ret

eis_above30:
    ficom FIFTY_W
    store_fpu_flags
    ja eis_above50

    fld EIS_B50[4]
    fld EIS_B50[0]
    ret

eis_above50:
    ficom SEVENTY_W
    store_fpu_flags
    ja eis_above70

    fld EIS_B70[4]
    fld EIS_B70[0]
    ret

eis_above70:
    ficom HUNDRED_W
    store_fpu_flags
    ja eis_above100

    fld EIS_B100[4]
    fld EIS_B100[0]
    ret

eis_above100:
    ficom HUNDRED_FOURTY_W
    store_fpu_flags
    ja eis_above140

    fld EIS_B140[4]
    fld EIS_B140[0]
    ret

eis_above140:
    ficom TWO_HUNDRED_W
    store_fpu_flags
    ja eis_above200

    fld EIS_B200[4]
    fld EIS_B200[0]
    ret

eis_above200:
    fist .tmp_word

    push ax
    push dx
    push si
    xor dx, dx

    mov ax, .tmp_word
    sub ax, TWO_HUNDRED_W

    div HUNDRED_W
    mul EIGHT_W

    ;mov dx, 400
    ;call min     ; max index is 400 + 4

    mov si, ax

    fld EIS_A200[si + 4]
    fld EIS_A200[si]

    pop si
    pop dx
    pop ax
    ret

lookup_eis endp


; Calculate employee's EIS contribution
; *No side effects
; Params
;   st(0): Earning total
; Returns
;   st(0): Employee EIS payable
calculate_eis proc

    cmp [bx].has_eis, 0
    jne calc_eis

    ; no eis\
    fldz
    ret

calc_eis:
    call lookup_eis
    fpop
    ret

calculate_eis endp