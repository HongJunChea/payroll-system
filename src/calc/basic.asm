; Calculate the basic salary of an employee, does not account for overtime and holidays
; orp * (hours_worked + min(remaining_pto, leaves_taken))
; Params
;   bx: pointer to employee
; Returns
;   st(0): the basic salary
calculate_basic proc

    push ax
    push dx

    fld [bx].orp

    ; calculate hours_worked
    mov ax, [bx].monthly_leaves
    mov dx, [bx].pto
    call min

    add ax, [bx].hours_worked

    ; multiply hours
    mov .tmp_word, ax
    fimul .tmp_word

    pop dx
    pop ax
    ret

calculate_basic endp