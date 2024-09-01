generate_data proc

    push bx
    push si

    lea bx, employees
    mov si, 0

    call set_emp_id
    strcpy emp_name1 [bx][si].emp_name
    mov [bx][si].job_type, 2
    mov [bx][si].orp, 15.0
    mov [bx][si].pto, 300
    mov [bx][si].has_epf, 1
    mov [bx][si].has_socso, 1
    mov [bx][si].has_eis, 1

    add si, size employee

    call set_emp_id
    strcpy emp_name2 [bx][si].emp_name
    mov [bx][si].job_type, 1
    mov [bx][si].orp, 8.50
    mov [bx][si].pto, 0
    mov [bx][si].has_epf, 0
    mov [bx][si].has_socso, 0
    mov [bx][si].has_eis, 0

    add si, size employee

    ; MOV SI,OFFSET EMPLOYEES.emp_name[105], John
    ; MOV EMPLOYEES.job_type[0], 1
    ; MOV EMPLOYEES.orp[105], 8.50
    ; MOV EMPLOYEES.pto[105], 0
    ; MOV EMPLOYEES.has_epf[105], 0
    ; MOV EMPLOYEES.has_socso[105], 0
    ; MOV EMPLOYEES.has_eis[105], 0

    ; MOV SI,OFFSET EMPLOYEES.emp_name[140], Bob
    ; MOV EMPLOYEES.job_type[0], 1
    ; MOV EMPLOYEES.orp[140], 8.50
    ; MOV EMPLOYEES.pto[140], 50
    ; MOV EMPLOYEES.has_epf[140], 0
    ; MOV EMPLOYEES.has_socso[140], 0
    ; MOV EMPLOYEES.has_eis[140], 0

    ; MOV SI,OFFSET EMPLOYEES.emp_name[175], Smith
    ; MOV EMPLOYEES.job_type[0], 2
    ; MOV EMPLOYEES.orp[175], 15.0
    ; MOV EMPLOYEES.pto[175], 300
    ; MOV EMPLOYEES.has_epf[175], 1
    ; MOV EMPLOYEES.has_socso[175], 1
    ; MOV EMPLOYEES.has_eis[175], 1

    ; MOV SI,OFFSET EMPLOYEES.emp_name[210], David
    ; MOV EMPLOYEES.job_type[0], 2
    ; MOV EMPLOYEES.orp[210], 15.0
    ; MOV EMPLOYEES.pto[210], 300
    ; MOV EMPLOYEES.has_epf[210], 1
    ; MOV EMPLOYEES.has_socso[210], 1
    ; MOV EMPLOYEES.has_eis[210], 1

    ; MOV SI,OFFSET EMPLOYEES.emp_name[245], Dany
    ; MOV EMPLOYEES.job_type[0], 2
    ; MOV EMPLOYEES.orp[245], 15.0
    ; MOV EMPLOYEES.pto[245], 200
    ; MOV EMPLOYEES.has_epf[245], 1
    ; MOV EMPLOYEES.has_socso[245], 1
    ; MOV EMPLOYEES.has_eis[245], 1

    ; MOV SI,OFFSET EMPLOYEES.emp_name[280], Emily
    ; MOV EMPLOYEES.job_type[0], 1
    ; MOV EMPLOYEES.orp[280], 8.50
    ; MOV EMPLOYEES.pto[280], 150
    ; MOV EMPLOYEES.has_epf[280], 0
    ; MOV EMPLOYEES.has_socso[280], 0
    ; MOV EMPLOYEES.has_eis[280], 0

    ; MOV SI,OFFSET EMPLOYEES.emp_name[315], Eve
    ; MOV EMPLOYEES.job_type[0], 1
    ; MOV EMPLOYEES.orp[315], 8.50
    ; MOV EMPLOYEES.pto[315], 100
    ; MOV EMPLOYEES.has_epf[315], 0
    ; MOV EMPLOYEES.has_socso[315], 0
    ; MOV EMPLOYEES.has_eis[315], 0

    ; MOV SI,OFFSET EMPLOYEES.emp_name[350], Lee
    ; MOV EMPLOYEES.job_type[0], 2
    ; MOV EMPLOYEES.orp[350], 15.0
    ; MOV EMPLOYEES.pto[350], 300
    ; MOV EMPLOYEES.has_epf[350], 1
    ; MOV EMPLOYEES.has_socso[350], 1
    ; MOV EMPLOYEES.has_eis[350], 1

    ; MOV SI,OFFSET EMPLOYEES.emp_name[385], Jenny
    ; MOV EMPLOYEES.job_type[0], 2
    ; MOV EMPLOYEES.orp[385], 15.0
    ; MOV EMPLOYEES.pto[385], 300
    ; MOV EMPLOYEES.has_epf[385], 1
    ; MOV EMPLOYEES.has_socso[385], 1
    ; MOV EMPLOYEES.has_eis[385], 1

    push si
    push bx
    ret

generate_data endp