; create information for an employee, appended to the top
; Returns
;   bx: pointer to the added employee
create_employee proc

    push ax

	; auto calc offset
	mov al, size employee
	mul .number_of_emps

    ; move to empty employee space
	lea bx, employees
	add bx, ax

	pop ax

	call set_emp_id
    call edit_employee
    cmp dl, 1
    je create_employee_exit

	inc .number_of_emps

create_employee_exit:
    ret

create_employee endp


; set employee id in form of E00xx where xx is the number of employees
; Params
;	bx: employee pointer
set_emp_id proc

	push ax
	push si

	xor ax, ax

	mov si, 5   ; employee id length
    dec si      ; zero index it

	mov al, .number_of_emps
	inc al

	set_emp_id_loop:
		div TEN_B

		add ah, "0"       ; convert to ascii number

		mov [bx][si], ah  ; set to
		dec si

		xor ah, ah        ; clear remainder

		test al, al       ; can still divide 10?
		jnz set_emp_id_loop

	pop si
	pop ax
	ret

set_emp_id endp
