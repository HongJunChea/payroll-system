EXIT MACRO exit_code
    MOV AH, 4CH
    MOV AL, exit_code
    INT 21H

ENDM


PUTC MACRO c
    PUSH AX
    PUSH DX

    MOV DL, c
    MOV AH, 02H
    INT 21H

    POP DX
    POP AX

ENDM


PUTS MACRO s
    PUSH AX
    PUSH DX

    LEA DX, s

    MOV AH, 09H
    INT 21H

    POP DX
    POP AX

ENDM

;***************************************************************
; This macro defines a procedure to get a null terminated
; string from user, the received string is written to buffer
; at DS:DI, buffer size should be in DX.
; Procedure stops the input when 'Enter' is pressed.
DEFINE_GET_STRING MACRO
    LOCAL   empty_buffer, wait_for_key, skip_proc_get_string
    LOCAL exit, add_to_buffer

    ; protect from wrong definition location:
    JMP skip_proc_get_string

GET_STRING PROC NEAR
    PUSH AX
    PUSH CX
    PUSH DI
    PUSH DX

    MOV CX, 0 ; char counter.

    CMP DX, 1        ; buffer too small?
    JBE empty_buffer ;

    DEC DX ; reserve space for last zero.

    ;============================
    ; loop to get and processes key presses:

    wait_for_key:
        MOV AH, 0 ; get pressed key.
        INT 16h

        CMP AL, 13 ; 'RETURN' pressed?
        JZ  exit


        CMP  AL, 8         ; 'BACKSPACE' pressed?
        JNE  add_to_buffer
        JCXZ wait_for_key  ; nothing to remove!
        DEC  CX
        DEC  DI
        PUTC 8             ; backspace.
        PUTC ' '           ; clear position.
        PUTC 8             ; backspace again.
        JMP  wait_for_key

    add_to_buffer:

        CMP CX, DX       ; buffer is full?
        JAE wait_for_key ; if so wait for 'BACKSPACE' or 'RETURN'...

        MOV [DI], AL
        INC DI
        INC CX

        ; print the key:
        MOV AH, 0Eh
        INT 10h

        JMP wait_for_key
    ;============================

    exit:
        ; terminate by null:
        MOV [DI], 0

    empty_buffer:
        POP DX
        POP DI
        POP CX
        POP AX

    RET

GET_STRING          ENDP

skip_proc_get_string:

ENDM


;***************************************************************
; this macro defines procedure to clear the screen,
; (done by scrolling entire screen window),
; and set cursor position to top of it:
DEFINE_CLEAR_SCREEN MACRO
    LOCAL skip_proc_clear_screen

    ; protect from wrong definition location:
    JMP skip_proc_clear_screen

CLEAR_SCREEN PROC NEAR
    PUSH AX ; store registers...
    PUSH DS ;
    PUSH BX ;
    PUSH CX ;
    PUSH DI ;

    MOV AX, 40h
    MOV DS, AX   ; for getting screen parameters.
    MOV AH, 06h  ; scroll up function id.
    MOV AL, 0    ; scroll all lines!
    MOV BH, 07   ; attribute for new lines.
    MOV CH, 0    ; upper row.
    MOV CL, 0    ; upper col.
    MOV DI, 84h  ; rows on screen -1,
    MOV DH, [DI] ; lower row (byte).
    MOV DI, 4Ah  ; columns on screen,
    MOV DL, [DI]
    DEC DL       ; lower col.
    INT 10h

    ; set cursor position to top
    ; of the screen:
    MOV BH, 0  ; current page.
    MOV DL, 0  ; col.
    MOV DH, 0  ; row.
    MOV AH, 02
    INT 10h

    POP DI ; re-store registers...
    POP CX ;
    POP BX ;
    POP DS ;
    POP AX ;

    RET
CLEAR_SCREEN        ENDP

skip_proc_clear_screen:

ENDM


;***************************************************************
; This macro defines a procedure that prints number in AX,
; used with PRINT_NUM_UNS to print signed numbers:
; Requires DEFINE_PRINT_NUM_UNS !!!
DEFINE_PRINT_NUM MACRO
    LOCAL not_zero, positive, printed, skip_proc_print_num

    ; protect from wrong definition location:
    JMP                 skip_proc_print_num

PRINT_NUM PROC NEAR
    PUSH AX

    ; the check SIGN of AX,
    ; make absolute if it's negative:
    CMP AX, 0
    JNS positive

    NEG AX
    PUTC '-'

    positive:
        CALL PRINT_NUM_UNS

    POP AX
    RET
PRINT_NUM            ENDP

skip_proc_print_num:

ENDM


;***************************************************************
; This macro defines a procedure that prints out an unsigned
; number in AX (not just a single digit)
; allowed values from 0 to 65535 (0FFFFh)
DEFINE_PRINT_NUM_UNS MACRO
    LOCAL divide, print_all, ten
    LOCAL skip_proc_print_num_uns

    ; protect from wrong definition location:
    JMP skip_proc_print_num_uns

    ten DW 10 ; used as divider.

PRINT_NUM_UNS PROC NEAR
    PUSH AX
    PUSH CX
    PUSH DX

    XOR CX, CX  ; clear loop

    DIVIDE:
        XOR DX, DX ; clear remainder

        DIV ten

        PUSH DX
        INC CX

        TEST AX, AX
        JNZ DIVIDE

    PRINT_ALL:
        POP DX
        ADD DX, "0"

        PUTC DL

        LOOP PRINT_ALL

    POP DX
    POP CX
    POP AX
    RET

PRINT_NUM_UNS ENDP

skip_proc_print_num_uns:

ENDM
