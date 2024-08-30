.MODEL SMALL
.STACK 100
.DATA

	NAME_PROMPT DB 'Enter employee name: $'
	TYPE_PROMPT DB 'Enter 1 for Part-time or 2 for Full-time: $'
	HOURLY_PROMPT DB 'Enter hourly wage (for Part-time): $'
	SALARY_PROMPT DB 'Enter monthly salary (for Full-time): $'
	HOURS_PROMPT DB 'Enter number of working hours per month: $'

	PTO_PROMPT DB 'Enter total PTO hours per year: $'
	EPF_PROMPT DB 'Does the employee have EPF? (Y/N): $'
	SOCSO_PROMPT DB 'Does the employee have SOCSO? (Y/N): $'
	EIS_PROMPT DB 'Does the employee have EIS? (Y/N): $'

	NL DB 0AH, 0DH, '$'

	EMP_NAME DB 20 DUP('$')		;STORE EMP NAME
	HOURLY_WAGE DB 5 DUP('$')	;STORE WAGE/H
	MONTHLY_SALARY DB 5 DUP('$')	;STORE MONTHLY SALARY
	WORK_HOURS DB 5 DUP('$')	;STORE WORK HOURS
	HOURLY_RATE DB 5 DUP('$')	;STORE FT WAGE/H
	PTO_HOURS DB 5 DUP('$')
	PTO_PER_MONTH DB 5 DUP('$')
	EPF DB ?
    SOCSO DB ?
   	EIS DB ?


.CODE
MAIN PROC
	MOV AX,@DATA
	MOV DS,AX
		
	
	MOV AH, 09H	;--------GET EMP NAME
   	LEA DX, NAME_PROMPT
   	INT 21H
		
	MOV AH, 0AH  	;--------INPUT EMP NAME
    LEA DX, EMP_NAME
	INT 21H
		
	MOV AH,09H	    ;--------NEWLINE
	LEA DX,NL
	INT 21H

	MOV AH, 09H	    ;---------GET JOB TYPE(PT/FT)
    LEA DX, TYPE_PROMPT
	INT 21H
	
 	MOV AH, 01H	    ;---------INPUT JOB TYPE
  	INT 21H
  	SUB AL, 30H

	CMP AL, 1	    ;---------COMPARE
	JE PT
	CMP AL, 2
	JE FT
	JMP FIN

PT:
	MOV AH, 09H	    ;---------GET WAGE/h
	LEA DX, HOURLY_PROMPT
   	INT 21H
	
	MOV AH,	0AH	    ;---------GET INPUT
	LEA DX, HOURLY_WAGE
	INT 21H

	JMP FIN
	
FT:
	MOV AH, 09H	    ;---------GET MONTHLY SALARY
	LEA DX, SALARY_PROMPT
	INT 21H

	MOV AH, 0AH	    ;---------GET INPUT
	LEA DX, MONTHLY_SALARY
	INT 21H

	MOV AH, 09H	    ;---------GET HOURS PER MONTH
	LEA DX, HOURS_PROMPT
	INT 21H
	
	MOV AH, 0AH	    ;---------GET INPUT
	LEA DX, WORK_HOURS
	INT 21H

			        ;---------COUNT
	MOV AX, MONTHLY_SALARY
	MOV BX, WORK_JOURS
	DIV BX		    ;---------AX/BX
	ADD AL, 30H
	MOV HOURLY_RATE, AL

	JMP EMP_INFO


EMP_INFO:

	MOV AH, 09H	    ;---------PTO 
	LEA DX, PTO_PROMPT
	INT 21H

	MOV AH, 0AH	    ;---------GET PTO HOURS
	LEA DX, PTO_HOURS
	INT 21H
		
			        ;---------COUNT PTO
	MOV AX, PTO_HOURS
	MOV BX, 12	    ;---------12 MONTH
	DIV BX
	MOV PTO_PER_MONTH, AL

;--------------------------------------------------------------------------------------

	MOV AH, 09H	    ;---------EPF
	LEA DX, EPF_PROMPT
	INT 21H

	MOV AH, 01H	    ;---------INPUT EPF
	INT 21H
	MOV EPF, AL

	CMP EPF, 'Y'
	JE EPF_YES
	CMP EPF, 'N'
	JE EPF_NO
	
	JMP FIN

EMP_YES:
	
	;-----COUNT EPF
	
	JMP SOCSO

EMP_NO:
	
	;-----COUNT EPF

	JMP SOCSO
	
SOCSO:

        MOV AH, 09H	 ;---------SOCSO
    	LEA DX, SOCSO_PROMPT
    	INT 21H

    	MOV AH, 01H  ;---------INPUT SOCSO
    	INT 21H
    	MOV SOCSO, AL


	CMP SOCSO, 'Y'
	JE SOCSO_YES
	CMP SOCSO, 'N'
	JE SOCSO_NO

	JMP FIN

SOCSO_YES:

	;-------COUNT
	
	JMP EIS

SOCSO_NO:


	;-------COUNT

	JMP EIS


EIS:

        MOV AH, 09H	    ;---------EIS
    	LEA DX, EIS_PROMPT
    	INT 21H

    	MOV AH, 01H  	;---------INPUT EIS
    	INT 21H
    	MOV EIS, AL

    	MOV AH, 09H	    ;---------NEWLINE
    	LEA DX, NL
    	INT 21H

	CMP EIS, 'Y'
	JE EIS_YES
	CMP EIS, 'N'
	JE EIS_NO

	JMP FIN

EIS_YES:

	;-------COUNT
	JMP FIN

EIS_NO:

	;-------COUNT
	JMP FIN



FIN:
	
	MOV AX,4C00H
	INT 21H
MAIN ENDP
END MAIN