OVERTIME_RATE DD 2.0
HOLIDAY_RATE DD 3.0

.number_of_emps DB 0

employee struc

    emp_id     DB "E0000$"
    emp_name   DB 19 DUP (?), "$"
    job_type   DB ?   ; 1 = parttime, 2 = fulltime
    orp        DD ?   ; ordinary rate of pay
    pto        DW ?   ; paid time off, in hours
    has_epf    DB ?
    has_socso  DB ?
    has_eis    DB ?

    ; monthly reports
    filled_performance DB 0   ; boolean to show filled performance
    hours_worked       DW ?
    monthly_leaves     DW ?   ; only used for fulltime
    overtime_hours     DW ?
    holiday_hours      DW ?
    claimed_pto        DW ?

employee ENDS
