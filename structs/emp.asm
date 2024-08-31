emp_id_sequence DB 1

employee struc

    emp_id DB "E0000"
    emp_name DB 20  ; string length
             DB ?   ; actual string length
             DB 20 DUP ("$") 
    orp DD ?        ; ordinary rate of pay
    bonus DD ?
    pto DB ?
    has_epf DB ?
    has_socso DB ?
    has_eis   DB ?

    ; monthly reports
    hours_worked DW ?
    monthly_leaves DB ?
    overtime_hours DB ?
    holiday_hours DB ?
    
employee ENDS
