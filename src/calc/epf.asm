; Source: https://www.kwsp.gov.my/en/employer/responsibilities/mandatory-contribution
;         https://www.kwsp.gov.my/documents/d/guest/jadual-ketiga-bi-pdf-1


; Lookup epf contribution from table
; *No side effects
; extra note: salary maximum 546125 due to 12% exceeding word size, can be rewritten to use ebx and ecx
; Params
;   st(0): current salary
; Returns
;   bx: employer payable
;   cx: employee payable
lookup_epf proc far

    ficom .ten             ; if > 10
    store_fpu_flags

    ja is_above10

    ; no epf for salary below 10
    mov bx, 0
    mov cx, 0
    ret

is_above10:

    ficom .twenty_thousand ; if <= 20000
    store_fpu_flags

    jbe is_below20k

; is_above_20k
    call lookup_epf_above20k
    ret

is_below20k:
    call lookup_below20k
    ret


lookup_epf_above20k proc

    change_rounding .round_up

    fld   st(0)           ; duplicate current salary
    fmul  .twelve_percent ; x 12%
    frndint               ; round up to nearest int
    fistp .tmp_word       ; store result
    mov   bx, .tmp_word
    
    fld   st(0)           ; duplicate current salary
    fmul  .eleven_percent ; x 11%
    frndint               ; round up to nearest int
    fistp .tmp_word       ; store result
    mov   cx, .tmp_word

    restore_rounding
    ret

lookup_epf_above20k endp


lookup_epf_below20k proc

    push ax
    push dx
    push di

    xor dx, dx

    ; store salary to ax
    fist .tmp_word
    mov  ax, .tmp_word

    ficom .five_thousand    ; if above 5k
    store_fpu_flags

    ja    is_above_5k

; is_below_5k:

    lea bx, .b5k_contrib    ; chooses the lookup table

    ; formula goes: floor(salary / 20) * 20 = index
    div .twenty             ; get floor of salary / 20, wont use remainder
    mul .four               ; each epf data section is 4 byte wide

    jmp lookup_epf_below20k_calc

is_above_5k:

    lea bx, .b20k_contrib   ; chooses the lookup table

    ; formula goes: floor(salary / 100) * 100 = index
    sub ax, .five_thousand  ; offset the value by 5000
   
    div .hundred            ; get floor of salary / 100, wont use remainder
    mul .four               ; each epf data section is 4 byte wide

    ; jmp .calculate

lookup_epf_below20k_calc:
    
    mov di, ax

    ; cx before bx because bx stores the table address
    mov cx, [bx + di + 2]
    mov bx, [bx + di]

    pop di
    pop dx
    pop ax

    ret

lookup_epf_below20k endp


lookup_epf      endp
