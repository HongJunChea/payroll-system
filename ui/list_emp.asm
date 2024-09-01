.MODEL SMALL
.STACK 100
.DATA

    MOV BX, OFFSET EMPLOYEES

    MOV CX, 12
    MOV SI, 0


.CODE
MAIN PROC
	MOV AX,@DATA
	MOV DS,AX

    
PRINT ALL:
    MOV AL, [BX][SI].emp_name
    PUTS [BX][SI].emp_name 

    putc" "
    putc" "

    MOV AL, [BX][SI].orp
    CALL print_num_unsigned
    
    putc" "
    putc" "

    MOV AL, [BX][SI].pto
    CALL print_num_unsigned

    putc" "
    putc" "

    MOV AL, [BX][SI].has_epf
    CALL print_num_unsigned

    putc" "
    putc" "

    MOV AL, [BX][SI].has_socso
    CALL print_num_unsigned

    putc" "
    putc" "

    MOV AL, [BX][SI].has_eis
    CALL print_num_unsigned

    putc 10

    add si, size employee
    loop print_all
    
    

	
	MOV AX,4C00H
	INT 21H
MAIN ENDP
END MAIN