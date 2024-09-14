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
    ret

lookup_eis endp


calculate_eis proc

    cmp [bx].has_eis, 0
    jne .calc_eis_yes

    fldz
    ret

.calc_eis_yes:
    push bx
    push cx

    fld .emp_perf_earn_total_tmp
    call calculate_eis
    fpop

    mov .tmp_word, dx
    fild .tmp_word

    pop cx
    pop bx
    ret

calculate_eis endp