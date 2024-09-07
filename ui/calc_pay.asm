calculate_pay proc

    fldpi
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