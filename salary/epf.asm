; Source: https://www.kwsp.gov.my/en/employer/responsibilities/mandatory-contribution
;         https://www.kwsp.gov.my/documents/d/guest/jadual-ketiga-bi-pdf-1

include ..\data\epf.asm

; local .old_round, .current_round, .round_bankers, .round_up, .round_down, .round_to_zero
.old_round     DW ?
.current_round DW ?

.round_bankers DB 00000000b
.round_up      DB 00001000b
.round_down    DB 00000100b
.round_to_zero DB 00001100b
; http://www.website.masmforum.com/tutorials/fptute/fpuchap1.htm
change_rounding macro round_mode

    push ax

    fstcw .current_round          
    mov ax, .current_round  ; move to ax for controlling ah
    mov .old_round, ax      ; store for restoring

    and ah, 11110011b       ; clear round control bit
    or  ah, round_mode      ; set round control bit

    mov .current_round, ax  ; move back
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
.tmp_word dw ?
.five_thousand   dw 5000
.twenty_thousand dw 20000

.twenty          dw 20
.hundred         dw 100

.four            dw 4

.twelve_percent  dd 0.12
.eleven_percent  dd 0.11
lookup_epf proc far

    ficom .twenty_thousand   ; if <= 20000
    jbe .below20k

    jmp .above20k

.below20k:
    call lookup_below20k
    ret

.above20k:
    call lookup_above20k
    ret
    

lookup_above20k proc

    change_rounding .round_up

    fld st(0)  ; duplicate current salary
    fmul .twelve_percent
    frndint
    fistp .tmp_word
    mov bx, .tmp_word
    
    fld st(0)  ; duplicate current salary
    fmul .eleven_percent
    frndint
    fistp .tmp_word
    mov cx, .tmp_word

    restore_rounding

    ret

lookup_above20k endp


lookup_below20k proc

    push ax
    push dx
    push di

    ; formula goes: floor(n / 20) * 20 = index 
    fist .tmp_word
    mov ax, .tmp_word

    ficom .five_thousand
    jge .20k

.5k:

    div .twenty  ; get floor of n / 20, wont use remainder
    mul .four  ; each epf data section is 4 byte wide
    mov ax, dx
    
    mov bx, offset b5k_contrib

    jmp .calculate

.20k:
    sub ax, .five_thousand
   

    div .hundred  ; get floor of n / 100, wont use remainder
    mul .four  ; each epf data section is 4 byte wide
    mov ax, dx

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


lookup_epf endp
