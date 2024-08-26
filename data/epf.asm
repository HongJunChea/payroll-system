; Source: https://www.kwsp.gov.my/en/employer/responsibilities/mandatory-contribution
;         https://www.kwsp.gov.my/documents/d/guest/jadual-ketiga-bi-pdf-1

epf segment public


; data is laid out as <1_employee_contrib, 1employer_contrib, 2_employee_contrib, 2_employer_contrib, ..., n_employee_contrib, n_employer_contrib>
; each row is a multiple of RM20
; TODO: fill data
b5k_contrib dw 3 dw 3
            dw 6 dw 5
            

; each row is a multiple of RM100
b20k_contrib dw 612 dw 561





epf ends