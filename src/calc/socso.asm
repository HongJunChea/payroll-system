; Lookup and calculate socso contribution from table
; *No side effects
; extra note: salary maximum 546125 due to 12% exceeding word size, can be rewritten to use ebx and ecx
; Params
;   st(0): current salary
; Returns
;   ax: employer payable
;   dx: employee payable
lookup_socso proc

    ; TODO:
    xor ax, ax  ; set ax = 0
    xor dx, dx  ; set dx = 0
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
    push bx
    push cx

    call lookup_socso

    mov .tmp_word, dx
    fild .tmp_word

    pop cx
    pop bx
    ret

calculate_socso endp