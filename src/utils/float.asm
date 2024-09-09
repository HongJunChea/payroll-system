; Prints float currently on the top of the stack.
; *No side effects
; Params
;   st(0): float to be printed
; Returns
;   none
print_float proc near
    push ax
    push dx

    fld st(0)                ; duplicates top float

    fist .tmp_word           ; load integral part of float
    mov ax, .tmp_word
    call print_num_unsigned  ; print integral part

    putc "."                 ; print decimal seperator

    fisub .tmp_word          ; remove integer part of float => 123.4567 -> 0.4567
    fimul HUNDRED_W           ; move decimal point two space left => 0.4567 -> 456.7

    fistp .tmp_word          ; load integral part
    mov ax, .tmp_word
    call print_num_unsigned  ; print integral part

    pop dx
    pop ax
    ret

print_float endp


; Accumulate and sum all the floating points in the stack
; Params
;   cx: number of floats
; Returns
;   st(0): accumulates and pop all floats into the sum
accumulate_sum proc

    dec cx
    cmp cx, 0
    jbe end_accumulate

    accumulate_sum_loop:
        faddp st(1), st(0)
        loop loop_calc_earn_total

    end_accumulate:
        ret

calculate_subtotal endp


;
; Macros
;
putfloat macro float

    fld float
    call print_float
    fpop

endm


fpop macro

    fstp st(0)

endm


; Change the current rounding
; http://www.website.masmforum.com/tutorials/fptute/fpuchap1.htm
change_rounding macro round_mode

    ; store current rounding
    fstcw .current_round                        ; store to memory
    fstcw .old_round                            ; store rounding for restoring

    ; edit round flag
    and byte ptr [.current_round], 11110011b    ; clear round control bit
    or  byte ptr [.current_round], round_mode   ; set round control bit

    ; load the new rounding
    fldcw .current_round

endm


; Restores the rounding to the last rounding
restore_rounding macro

    fldcw .old_round

endm


; Used to store comparison flags
; https://stackoverflow.com/questions/33755275/compare-instruction-not-working-correctly
store_fpu_flags macro

    fstsw ax
    fwait
    sahf      ; store ah flags

endm


fsum macro n

    mov cx, n
    call accumulate_sum

endm