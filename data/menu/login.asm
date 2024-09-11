INP_USERID db 10 dup(?)
user_id_length db 7
correct_id db "1234567"

;LOGIN MESSAGE
LOGIN1 db 'Welcome to the payroll system!!!!!',10,'$'
LOGIN2 db '------------------------------------',10,'$'
ID_ENT db 'Please enter your ID: $'

;INVALID ID MESSAGE
INVALID db 'Invalid ID, please try again!!!',10,'$'

;VALID ID MESSAGE
VALID db 'Valid ID, you may proceed to MENU!!!',10,'$'