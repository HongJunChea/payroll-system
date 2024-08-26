; Source: https://www.kwsp.gov.my/en/employer/responsibilities/mandatory-contribution
;         https://www.kwsp.gov.my/documents/d/guest/jadual-ketiga-bi-pdf-1

include ..\data\epf.asm

local .old_round, .current_round, .round_bankers, .round_up, .round_down, .round_to_zero
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
    mov .old_round, .current_round  ; store for restoring

    mov ax, .current_round  ; move to ax for controlling ah
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
;   bx: employee payable
;   cx: employer payable
local .tmp, .five_thousand, .twenty_thousand, .twenty, .hundred, .four, .twelve_percent, .eleven_percent
.tmp dw ?
.five_thousand   dw 5000
.twenty_thousand dw 20000

.twenty          dw 20
.hundred         dw 100

.four            db 4

.twelve_percent  dd 0.12
.eleven_percent  dd 0.11
lookup_epf proc far

    push ax
    push dx
    push di

    ficom .five_thousand   ; if <= 5000
    jbe .5k

    ficom .twenty_thousand ; if <= 20000
    jbe .20k

    jmp .more             ; > 20000

.5k:

    ; formula goes: floor(n / 20) * 20 = index 
    fist .tmp
    mov ax, .tmp 
    div .twenty  ; get floor of n / 20, wont use remainder

    mul .four  ; each epf data section is 4 byte wide
    mov di, ax

    mov bx, b5k_contrib[di]
    mov cx, b5k_contrib[di + 2]

    jmp .exit

.20k:

    ; floor(n / 100) * 100 = index  instead here
    fist .tmp
    mov ax, .tmp 
    div .hundred  ; get floor of n / 100, wont use remainder

    mul .four  ; each epf data section is 4 byte wide
    mov di, ax

    mov bx, b20k_contrib[di]
    mov cx, b20k_contrib[di + 2]

    jmp .exit

.more:

    change_rounding .round_up

    fld st(0)  ; duplicate current salary
    fmul .eleven_percent
    frndint
    fistp .tmp
    mov bx, .tmp
    
    fld st(0)  ; duplicate current salary
    fmul .twelve_percent
    frndint
    fistp .tmp
    mov cx, .tmp

    restore_rounding

    jmp .exit

.exit:

    pop di
    pop dx
    pop ax
    ret

lookup_epf endp
