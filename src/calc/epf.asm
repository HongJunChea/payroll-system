; Source: https://www.kwsp.gov.my/en/employer/responsibilities/mandatory-contribution
;         https://www.kwsp.gov.my/documents/d/guest/jadual-ketiga-bi-pdf-1


; Lookup epf contribution from table
; *No side effects
; extra note: salary maximum 546125 due to 12% exceeding word size, can be rewritten to use ebx and ecx
; Params
;   st(0): current salary
; Returns
;   ax: employer payable
;   dx: employee payable
lookup_epf proc far

    ficom TEN_W             ; if > 10
    store_fpu_flags

    ja is_above10

    ; no epf for salary below 10
    mov ax, 0
    mov dx, 0
    ret

is_above10:

    ficom TWENTY_THOUSAND_W ; if <= 20000
    store_fpu_flags

    jbe is_below20k

; is_above_20k
    call lookup_epf_above20k
    ret

is_below20k:
    call lookup_below20k
    ret


lookup_epf_above20k proc

    change_rounding ROUND_UP

    fld   st(0)           ; duplicate current salary
    fmul  TWELVE_PERCENT_W ; x 12%
    frndint               ; round up to nearest int
    fistp .tmp_word       ; store result
    mov   ax, .tmp_word
    
    fld   st(0)           ; duplicate current salary
    fmul  ELEVEN_PERCENT_W ; x 11%
    frndint               ; round up to nearest int
    fistp .tmp_word       ; store result
    mov   dx, .tmp_word

    restore_rounding
    ret

lookup_epf_above20k endp


lookup_epf_below20k proc

    push di

    xor dx, dx

    ; store salary to ax
    fist .tmp_word
    mov  ax, .tmp_word

    ficom FIVE_THOUSAND_W    ; if above 5k
    store_fpu_flags

    ja    is_above_5k

; is_below_5k:
    lea bx, B5K_EPF_CONTRIB    ; chooses the lookup table

    ; formula goes: floor(salary / 20) * 20 = index
    div TWENTY_W             ; get floor of salary / 20, wont use remainder
    mul FOUR_W               ; each epf data section is 4 byte wide

    jmp lookup_epf_below20k_calc

is_above_5k:
    lea bx, B20K_EPF_CONTRIB   ; chooses the lookup table

    ; formula goes: floor(salary / 100) * 100 = index
    sub ax, FIVE_THOUSAND_W  ; offset the value by 5000
   
    div HUNDRED_W            ; get floor of salary / 100, wont use remainder
    mul FOUR_W               ; each epf data section is 4 byte wide

    ; jmp .calculate

lookup_epf_below20k_calc:
    mov di, ax

    mov ax, [bx + di]
    mov dx, [bx + di + 2]

    pop di
    ret

lookup_epf_below20k endp

lookup_epf      endp



calculate_epf proc

    cmp [bx].has_epf, 0
    jne .calc_epf_yes

    fldz
    ret

.calc_epf_yes:
    push ax
    push dx

    fld .emp_perf_earn_total_tmp
    call calculate_epf
    fpop

    mov .tmp_word, dx
    fild .tmp_word

    pop dx
    pop ax
    ret

calculate_epf endp