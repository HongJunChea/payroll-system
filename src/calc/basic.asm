; Calculate the basic salary of an employee, does not account for overtime and holidays
; orp * (hours_worked + claimed_pto)
; Params
;   bx: pointer to employee
; Returns
;   st(0): the basic salary
calculate_basic proc

    push ax

    fld [bx].orp

    mov ax, [bx].hours_worked
    add ax, [bx].claimed_pto

    ; multiply hours
    mov .tmp_word, ax
    fimul .tmp_word

    pop ax
    ret

calculate_basic endp