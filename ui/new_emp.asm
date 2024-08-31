; set information for an employee
; Parameters
;	bx: pointer to the employee
create_emp proc

	xor eax, eax

	call set_emp_id
	inc emp_id_sequence
	
	puts NAME_PROMPT
	scans [bx].emp_name
	putc 10

get_type:
	puts TYPE_PROMPT
	scann al
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

	puts HOURLY_PROMPT
	call input_num
	mov [bx].orp, eax

	ret

handle_part_time endp


handle_full_time proc

	puts SALARY_PROMPT
	call input_num
	
	mov input_tmp, ax
	fild input_tmp
	fidiv hours_per_months
	fstp [bx].orp

	puts PTO_PROMPT
	call input_num
	mov [bx].pto, al

get_epf:
	puts EPF_PROMPT
	scanc al
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
	scanc al
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
	scanc al
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


set_emp_id proc

	push ax
	push dx
	push si

	mov si, emp_id_length
	dec si
	mov al, emp_id_sequence

	set_emp_id_loop:
		div .ten_b
		
		add ah, "0"
		mov [bx][si], ah
		dec si

		test al, al
		jnz set_emp_id_loop

	pop si
	pop dx
	pop ax
	ret

set_emp_id endp

create_emp endp
