; set information for an employee
; Parameters
;	bx: pointer to the employee
edit_employee proc

	puts NAME_PROMPT
	gets [bx].emp_name_buffer
	putc 10

get_type:
	puts TYPE_PROMPT
	getd al
	putc 10

	CMP AL, 1	    ;---------COMPARE
	JE pt
	CMP AL, 2
	JE ft
	jmp get_type

pt:
	call handle_part_time
	ret

ft:
	call handle_full_time
	ret


handle_part_time proc

	mov [bx].job_type, 1

	puts HOURLY_PROMPT
	call input_num
	mov [bx].orp, eax

	ret

handle_part_time endp


handle_full_time proc

	mov [bx].job_type, 2

	puts SALARY_PROMPT
	call input_num

	mov .tmp_word, ax
	fild .tmp_word
	fidiv HOURS_PER_MONTHS
	fstp [bx].orp

	puts PTO_PROMPT
	call input_num
	mov [bx].pto, ax

get_epf:
	puts EPF_PROMPT
	getc al
	putc 10

	cmp al, "y"
	je epf_yes
	cmp al, "Y"
	je epf_yes

	cmp al, "n"
	je epf_no
	cmp al, "N"
	je epf_no

	jmp get_epf

epf_yes:
	mov [bx].has_epf, 1
	jmp get_socso

epf_no:
	mov [bx].has_epf, 0


get_socso:
	puts SOCSO_PROMPT
	getc al
	putc 10

	cmp al, "y"
	je socso_yes
	cmp al, "Y"
	je socso_yes

	cmp al, "n"
	je socso_no
	cmp al, "N"
	je socso_no

	jmp get_socso

socso_yes:
	mov [bx].has_socso, 1
	jmp get_eis

socso_no:
	mov [bx].has_socso, 0


get_eis:
	puts EIS_PROMPT
	getc al
	putc 10

	cmp al, "y"
	je eis_yes
	cmp al, "Y"
	je eis_yes

	cmp al, "n"
	je eis_no
	cmp al, "N"
	je eis_no

	jmp get_eis

eis_yes:
	mov [bx].has_eis, 1
	ret

eis_no:
	mov [bx].has_eis, 0
	ret

handle_full_time endp

edit_employee endp