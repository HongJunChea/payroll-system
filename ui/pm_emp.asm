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

    mov cx, emp_id_length
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



; find employee pointer to given the employee id
; Params
;   prompt_emp_id: filled id string
; Returns
;   bx: the employee pointer
;   zf: 1 = not found
;       0 = found
find_employee proc

    lea bx, employees
    
    xor ch, ch
    mov cl, number_of_employees

    sub bx, size employee       ; offset the initial add in the loop
    find_employee_loop:
        add bx, size employee   ; add sets zf, no good
        strcmp prompt_emp_id [bx].emp_id 5
        loopne find_employee_loop

    ret

find_employee endp