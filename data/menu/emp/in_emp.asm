NAME_PROMPT DB 'Enter employee name: $'
TYPE_PROMPT DB 'Enter 1 for Part-time or 2 for Full-time: $'
HOURLY_PROMPT DB 'Enter hourly wage (for Part-time): $'
SALARY_PROMPT DB 'Enter monthly salary (for Full-time): $'

PTO_PROMPT DB 'Enter total PTO hours per year: $'
EPF_PROMPT DB 'Does the employee have EPF? (Y/N): $'
SOCSO_PROMPT DB 'Does the employee have SOCSO? (Y/N): $'
EIS_PROMPT DB 'Does the employee have EIS? (Y/N): $'

input_tmp dw ?
hours_per_months dw 160   ; 8 hours * 5 days * 4 weeks
