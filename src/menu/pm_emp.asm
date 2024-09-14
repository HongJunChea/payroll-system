; prompt user to select an employee with id
; Returns
;   bx: the employee pointer
;   zf: 1 = not found
;       0 = found
prompt_employee proc

    prompt_employee_start:

    puts prompt_employee_msg
    call prompt_employee_get_id
    je prompt_employee_exit

    ; check valid id
    cmp prompt_emp_id[0], "E"
    jne prompt_employee_not_valid_id

    ; check can find employee
    call find_employee
    jne prompt_employee_not_found

    ret  ; leave

    prompt_employee_exit:
    cmp prompt_emp_id[0], "0"  ; set zf = 1 
    ret

    prompt_employee_not_valid_id:
        puts prompt_employee_not_valid_id_msg
        jmp prompt_employee_start

    prompt_employee_not_found:
        puts prompt_employee_not_found_msg
        jmp prompt_employee_start


prompt_employee endp



; Returns
;   zf: 1 = continue
;       0 = break
prompt_employee_get_id proc

    push ax

    mov cx, EMP_ID_LEN
    lea di, prompt_emp_id 
    prompt_employee_get_id_loop:
        input_char
        stosb

        cmp al, "q"
        loopne prompt_employee_get_id_loop

    putc 10

    pop ax
    ret

prompt_employee_get_id endp



