; Calculate the public holiday rate of the employee
; orp * ph_hours * ph_rate
; Params
;   bx: pointer to employee
; Returns
;   st(0): the public holiday rate
calculate_ph proc

    fld [bx].orp
    fimul [bx].holiday_hours
    fmul holiday_rate
    ret

calculate_ph endp