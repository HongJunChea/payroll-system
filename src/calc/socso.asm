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
    ret

lookup_socso endp


calculate_socso proc

    cmp [bx].has_socso, 0
    jne .calc_socso_yes

    fldz
    ret

.calc_socso_yes:
    push bx
    push cx

    fld .emp_perf_earn_total_tmp
    call calculate_epf
    fpop

    mov .tmp_word, dx
    fild .tmp_word

    pop cx
    pop bx
    ret

calculate_socso endp