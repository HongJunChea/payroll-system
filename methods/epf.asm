; Source: https://www.kwsp.gov.my/en/employer/responsibilities/mandatory-contribution
;         https://www.kwsp.gov.my/documents/d/guest/jadual-ketiga-bi-pdf-1

; http://www.website.masmforum.com/tutorials/fptute/fpuchap1.htm
change_rounding macro round_mode

    push ax

    fstcw .current_round
    mov   ax,         .current_round ; move to ax for controlling ah
    mov   .old_round, ax             ; store for restoring

    and ah, 11110011b  ; clear round control bit
    or  ah, round_mode ; set round control bit

    mov   .current_round, ax ; move back
    fldcw .current_round

    pop ax

endm


restore_rounding macro

    fldcw .old_round

endm


; Lookup epf contribution from table
; Params
;   st(0): current salary       note: wont be popped
;                               extra note: salary maximum 546125 due to 12% exceeding word size, can be rewritten to use ebx and ecx
; Returns
;   bx: employer payable
;   cx: employee payable
lookup_epf proc far

    ficom .twenty_thousand ; if <= 20000

    ; https://stackoverflow.com/questions/33755275/compare-instruction-not-working-correctly
    fstsw ax  ; load fpu comp
    fwait
    sahf

    jbe   .below20k

    jmp .above20k

.below20k:
    call lookup_below20k
    ret

.above20k:
    call lookup_above20k
    ret
    

lookup_above20k proc

    change_rounding .round_up

    fld   st(0)           ; duplicate current salary
    fmul  .twelve_percent
    frndint
    fistp .tmp_word
    mov   bx, .tmp_word
    
    fld   st(0)           ; duplicate current salary
    fmul  .eleven_percent
    frndint
    fistp .tmp_word
    mov   cx, .tmp_word

    restore_rounding

    ret

lookup_above20k endp


lookup_below20k proc

    push ax
    push dx
    push di

    xor dx, dx

    fist .tmp_word

    ficom .five_thousand

    fstsw ax ; load fpu comp
    fwait
    sahf

    ja    .20k

.5k:
    
    ; formula goes: floor(n / 20) * 20 = index 
    mov  ax, .tmp_word

    div .twenty ; get floor of n / 20, wont use remainder
    mul .four   ; each epf data section is 4 byte wide
    
    mov bx, offset b5k_contrib

    jmp .calculate

.20k:

    ; formula goes: floor(n / 100) * 100 = index 
    mov  ax, .tmp_word

    sub ax, .five_thousand
   
    div .hundred ; get floor of n / 100, wont use remainder
    mul .four    ; each epf data section is 4 byte wide

    mov bx, offset b20k_contrib

.calculate:
    
    mov di, ax

    mov cx, [bx + di + 2]
    mov bx, [bx + di]

    pop di
    pop dx
    pop ax

    ret

lookup_below20k endp


lookup_epf      endp
