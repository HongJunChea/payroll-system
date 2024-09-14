; create information for an employee, appended to the top
; Params
;   None
; Returns
;   bx: pointer to the added employee
create_employee proc

	; auto calc offset
	mov al, .number_of_emps
	mov bl, size employee
	mul bl

	lea bx, employees
	add bx, ax
	inc .number_of_emps
	xor ax, ax

	call set_emp_id
    call edit_employee

create_employee endp


; set employee id in form of E00xx where xx is the number of employees
; Params
;	bx: employee pointer
set_emp_id proc

	push ax
	push si

	xor ax, ax
	mov al, .number_of_emps
	mov si, EMP_ID_LEN
	dec si

	set_emp_id_loop:
		div TEN_B
		
		add ah, "0"
		mov [bx][si], ah
		dec si

		xor ah, ah
		test al, al
		jnz set_emp_id_loop

	pop si
	pop ax
	ret

set_emp_id endp
