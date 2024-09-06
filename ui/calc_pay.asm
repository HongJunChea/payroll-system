calculate_pay proc

    fldpi
    ret

calculate_pay endp


calculate_basic proc

    push ax

    fld [bx].orp

    xor ax, ax  ; clear ax
    cmp [bx].monthly_leaves, 0
    jbe have_leaves_cont  ; if no leaves, skip

    cmp [bx].monthly_leaves, [bx].pto  ; min(monthly_leaves, pto)
    ja take_pto

take_leaves:
    add ax, [bx].pto
    jmp have_leaves_cont

take_pto:
    add [bx].monthly_leaves
    jmp have_leaves_cont

have_leaves_cont:

    add ax, [bx].hours_worked

    mov .tmp_word, ax
    fimul .tmp_word

    pop ax
    ret

calculate_basic endp