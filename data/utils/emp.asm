EMP_NAME1 db "Alice$"
EMP_NAME2 db "Alex$"
EMP_NAME3 DB "Bob$"
EMP_NAME4 DB "Smith$"
EMP_NAME5 DB "David$"
EMP_NAME6 DB "Dany$"
EMP_NAME7 DB "Zuto$"
EMP_NAME8 DB "Eve$"
EMP_NAME9 DB "Lee$"
EMP_NAME10 DB "Max$"

JOB_FULLTIME db 2
JOB_PARTTIME db 1
ORP_FULLTIME dd 15.0
ORP_PARTTIME dd 8.50

PROMPT_EMP_MSG    db "Enter the employee id, ex. E0001 (Ctrl + C to Quit): $"
NOT_VALID_ID_MSG  db "That is not a valid employee id.", 10, "$"
EMP_NOT_FOUND_MSG db "Employee not found.", 10, "$"