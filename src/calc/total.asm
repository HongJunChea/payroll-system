; Calculate the total salary of employee
; Also sets auxiliary variable with calculation values. See payroll struct.
; Params
;   bx: pointer to employee
; Returns
;   st(0): total salary
;   values set in payroll struct
calculate_total proc

    call calculate_basic
    fst payroll.basic

    call calculate_ot
    fst payroll.ot

    call calculate_ph
    fst payroll.ph

    fsum 3
    fst payroll.earn_total

    call calculate_socso
    fstp payroll.socso

    call calculate_epf
    fstp payroll.epf

    call calculate_eis
    fstp payroll.eis

    fld payroll.socso
    fld payroll.epf
    fld payroll.eis

    fsum 3
    fst payroll.deduc_total

    fsubp st(1), st(0)
    fst payroll.total

    ret

calculate_total endp