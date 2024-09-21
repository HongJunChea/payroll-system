; Lookup and calculate socso contribution from table
; *No side effects
; extra note: salary maximum 546125 due to 12% exceeding word size, can be rewritten to use ebx and ecx
; Params
;   st(0): current salary
; Returns
;   st(0): employer payable
;   st(1): employee payable
lookup_socso proc

    ficom THIRTY_W
    store_fpu_flags
    ja socso_above30

    ; 0 - 30
    fld SOCSO_B30[4]
    fld SOCSO_B30[0]
    ret

socso_above30:
    ficom FIFTY_W
    store_fpu_flags
    ja socso_above50

    fld SOCSO_B50[4]
    fld SOCSO_B50[0]
    ret

socso_above50:
    ficom SEVENTY_W
    store_fpu_flags
    ja socso_above70

    fld SOCSO_B70[4]
    fld SOCSO_B70[0]
    ret

socso_above70:
    ficom HUNDRED_W
    store_fpu_flags
    ja socso_above100

    fld SOCSO_B100[4]
    fld SOCSO_B100[0]
    ret

socso_above100:
    ficom HUNDRED_FOURTY_W
    store_fpu_flags
    ja socso_above140

    fld SOCSO_B140[4]
    fld SOCSO_B140[0]
    ret

socso_above140:
    ficom TWO_HUNDRED_W
    store_fpu_flags
    ja socso_above200

    fld SOCSO_B200[4]
    fld SOCSO_B200[0]
    ret

socso_above200:
    fist .tmp_word

    push ax
    push dx
    push si
    xor dx, dx

    mov ax, .tmp_word
    sub ax, TWO_HUNDRED_W

    div HUNDRED_W
    mul EIGHT_W

    mov dx, 400
    call min     ; max index is 400 + 4

    mov si, ax

    fld SOCSO_A200[si + 4]
    fld SOCSO_A200[si]

    pop si
    pop dx
    pop ax
    ret

lookup_socso endp


; Calculate employee's SOCSO contribution
; *No side effects
; Params
;   st(0): Earning total
; Returns
;   st(0): Employee SOCSO payable
calculate_socso proc

    cmp [bx].has_socso, 0
    jne calc_socso

    ; no socso
    fldz
    ret

calc_socso:
    call lookup_socso
    fpop
    ret

calculate_socso endp