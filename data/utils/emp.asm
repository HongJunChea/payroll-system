EMP_NAME1 db "Alice"
EMP_NAME2 db "Alex"

JOB_FULLTIME db 2
JOB_PARTIME  db 1
ORP_FULLTIME dd 15.0
ORP_PARTTIME dd 8.50

PROMPT_EMP_MSG    db "Enter the employee id, ex. E0001 (Ctrl + C to Quit): $"
NOT_VALID_ID_MSG  db "That is not a valid employee id.", 10, "$"
EMP_NOT_FOUND_MSG db "Employee not found.", 10, "$"