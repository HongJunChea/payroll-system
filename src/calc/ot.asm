; Calculates the overtime rate of the employee
; orp * ot_hours * ot_rate
; Params
;   bx: pointer to employee
; Returns
;   st(0): the overtime rate
calculate_ot proc

    fld [bx].orp
    fimul [bx].overtime_hours
    fmul OVERTIME_RATE
    ret

calculate_ot endp