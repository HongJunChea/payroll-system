; Lookup and calculate epf contribution from table
; *No side effects
; extra note: salary maximum 546125 due to 12% exceeding word size, can be rewritten to use ebx and ecx
; Params
;   st(0): current salary
; Returns
;   ax: employer payable
;   dx: employee payable
lookup_eis proc

    ; TODO:
    xor ax, ax  ; set ax - 0
    xor dx, dx  ; set dx - 0
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
    push bx
    push cx

    call lookup_eis

    mov .tmp_word, dx
    fild .tmp_word

    pop cx
    pop bx
    ret

calculate_eis endp