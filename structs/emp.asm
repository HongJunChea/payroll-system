number_of_employees DB 0
emp_id_length DW 5

employee struc

    emp_id DB "E0000"
    emp_name_buffer DB 20  ; string length
    emp_name_length DB ?   ; actual string length
    emp_name        DB 20 DUP ("$") 
    job_type        DB ?   ; 1 = parttime, 2 = fulltime
    orp DD ?        ; ordinary rate of pay
    pto DB ?
    has_epf DB ?
    has_socso DB ?
    has_eis   DB ?

    ; monthly reports
    bonus DD ?
    hours_worked DW ?
    monthly_leaves DB ?
    overtime_hours DB ?
    holiday_hours DB ?
    
employee ENDS
