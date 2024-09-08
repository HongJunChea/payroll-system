calculate_pay proc

    call calculate_basic
    call calculate_ot
    call calculate_ph

    mov cx, 3
    call calculate_subtotal
    fst emp_perf_earn_total_tmp

    call calculate_socso
    call calculate_epf
    call calculate_eis

    mov cx, 3
    call calculate_subtotal

    fsubp st(1), st(0)

    ret

calculate_pay endp


calculate_basic proc

    push ax

    fld [bx].orp

    mov ax, [bx].hours_worked
    cmp [bx].monthly_leaves, 0
    jbe have_leaves_cont  ; if no leaves, skip

    push cx
    mov cx, [bx].pto
    cmp [bx].monthly_leaves, cx  ; min(monthly_leaves, pto)
    pop cx
    ja take_pto

; take_leaves
    add ax, [bx].pto
    jmp have_leaves_cont

take_pto:
    add ax, [bx].monthly_leaves

have_leaves_cont:
    mov .tmp_word, ax
    fimul .tmp_word

    pop ax
    ret

calculate_basic endp


calculate_ot proc

    fld [bx].orp
    fimul [bx].overtime_hours
    fmul overtime_rate
    ret

calculate_ot endp


calculate_ph proc

    fld [bx].orp
    fimul [bx].holiday_hours
    fmul holiday_rate
    ret

calculate_ph endp


calculate_subtotal proc

    dec cx
    cmp cx, 0
    jbe stop_calc_earn_total

loop_calc_earn_total:
    faddp st(1), st(0)
    loop loop_calc_earn_total

stop_calc_earn_total:
    ret

calculate_subtotal endp


calculate_socso proc

    cmp [bx].has_socso, 0
    jne .calc_socso_yes

    fldz
    ret

.calc_socso_yes:

    ; TODO: do
    fldz
    ret

calculate_socso endp


calculate_epf proc

    cmp [bx].has_epf, 0
    jne .calc_epf_yes

    fldz
    ret

.calc_epf_yes:

    push bx
    push cx

    fld emp_perf_earn_total_tmp
    call lookup_epf
    fstp st(0)

    mov .tmp_word, cx
    fild .tmp_word

    pop cx
    pop bx
    ret

calculate_epf endp


calculate_eis proc

    cmp [bx].has_eis, 0
    jne .calc_eis_yes

    fldz
    ret

.calc_eis_yes:

    ; TODO: do
    fldz
    ret

calculate_eis endp
