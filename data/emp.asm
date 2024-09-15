OVERTIME_RATE DD 2.0
HOLIDAY_RATE DD 3.0

.number_of_emps DB 0

employee struc

    emp_id DB "E0000$"
    emp_name_buffer DB 20  ; string length
    emp_name_length DB ?   ; actual string length
    emp_name        DB 20 DUP ("$") 
    job_type        DB ?   ; 1 = parttime, 2 = fulltime
    orp DD ?        ; ordinary rate of pay
    pto DW ?
    has_epf DB ?
    has_socso DB ?
    has_eis   DB ?

    ; monthly reports
    filled_performance DB 0    ; boolean to show filled performance
    hours_worked DW ?
    monthly_leaves DW ?  ; only used for fulltime
    overtime_hours DW ?
    holiday_hours DW ?
    
employee ENDS
