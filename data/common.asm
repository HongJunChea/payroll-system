TEN_B           db 10

FOUR_W            dw 4
EIGHT_W           dw 8
TEN_W             dw 10
TWENTY_W          dw 20
HUNDRED_W         dw 100
; THOUSAND_W        dw 1000  ; unused for now
FIVE_THOUSAND_W   dw 5000
TWENTY_THOUSAND_W dw 20000

TWELVE_PERCENT_W  dd 0.12
ELEVEN_PERCENT_W  dd 0.11

TRUE  db 1
FALSE db 0

PRESS_ANY_KEY DB "Press any key to continue", 10, "$"
DLINE_BORDER  DB "================================", 10, "$"
SLINE_BORDER  DB "--------------------------------", 10, "$"


.tmp_word dw ?
.input_buffer db 20 dup(?)