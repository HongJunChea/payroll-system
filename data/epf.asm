; Source: https://www.kwsp.gov.my/en/employer/responsibilities/mandatory-contribution
;         https://www.kwsp.gov.my/documents/d/guest/jadual-ketiga-bi-pdf-1

; change_rounding
.old_round     DW ?
.current_round DW ?

.round_bankers DB 00000000b
.round_up      DB 00001000b
.round_down    DB 00000100b
.round_to_zero DB 00001100b


; lookup_epf
.tmp_word dw ?
.five_thousand   dw 5000
.twenty_thousand dw 20000
.twenty          dw 20
.hundred         dw 100
.four            dw 4
.twelve_percent  dd 0.12
.eleven_percent  dd 0.11



; data is laid out as <1_employee_contrib, 1employer_contrib, 2_employee_contrib, 2_employer_contrib, ..., n_employee_contrib, n_employer_contrib>
; each row is a multiple of RM20
; TODO: fill data
b5k_contrib dw 3, 3   ; 0 - 20
            dw 6, 5   ; 20 - 40
        ; so on
            

; each row is a multiple of RM100
b20k_contrib dw 612, 561 ; 5000 - 5100
                         ; 5100 - 5200
                                ; so on
