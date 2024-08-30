employee struc

    emp_name DB 20  ; string length
             DB ?   ; actual string length
             DB 20 DUP ("$") 
    orp DD ?        ; ordinary rate of pay
    bonus DD ?
    pto DB ?
    pto_used DB ?
    has_epf DB ?
    has_socso DB ?
    has_eis   DB ?

employee ENDS
