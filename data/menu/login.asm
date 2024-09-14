.user_id_input db 10 dup(?)

.correct_pass_len db 7
.correct_pass     db "1234567"

LOGIN_MSG    db 'Welcome to the payroll system!!!!!',10,'$'
PROMPT_PASS  db 'Please enter your ID: $'
INVALID_PASS db 'Invalid ID, please try again!!!',10,'$'
INVALID_PASS db 'Valid ID, you may proceed to MENU!!!',10,'$'