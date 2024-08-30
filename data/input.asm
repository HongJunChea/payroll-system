.MODEL SMALL
.386
.STACK 100
.DATA

	include ..\struct\employee.asm

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

	employee1 employee <,,,,,,>


.CODE
include ..\utils\print.asm
include ..\utils\io.asm
include ..\utils\input.asm

handle_part_time proc

	puts HOURLY_PROMPT
	call input_num
	mov [employee1.orp], eax

	ret

handle_part_time endp


handle_full_time proc

	puts SALARY_PROMPT
	call input_num
	
	mov input_tmp, ax
	fild input_tmp
	fidiv hours_per_months
	fstp employee1.orp

	puts PTO_PROMPT
	call input_num
	mov employee1.pto, al

	; TODO: later
	mov employee1.pto_used, 0

get_epf:
	puts EPF_PROMPT
	scanc al

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
	mov employee1.has_epf, 1
	jmp get_socso

epf_no:
	mov employee1.has_epf, 0


get_socso:
	putc 10
	puts SOCSO_PROMPT
	scanc al

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
	mov employee1.has_socso, 1
	jmp get_eis

socso_no:
	mov employee1.has_socso, 0


get_eis:
	putc 10
	puts EIS_PROMPT
	scanc al

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
	mov employee1.has_eis, 1
	ret

eis_no:
	mov employee1.has_eis, 0
	ret

handle_full_time endp


MAIN PROC

	MOV AX,@DATA
	MOV DS,AX

	xor eax, eax
	
	puts NAME_PROMPT
	scans employee1.emp_name		
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
	exit 0

ft:
	call handle_full_time
	exit 0

MAIN ENDP
END MAIN