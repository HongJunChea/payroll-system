EIGHT_B           db 8
TEN_B             db 10

FOUR_W            dw 4
EIGHT_W           dw 8
TEN_W             dw 10
TWENTY_W          dw 20
THIRTY_W          dw 30
FIFTY_W           dw 50
SEVENTY_W         dw 70
HUNDRED_W         dw 100
HUNDRED_FOURTY_W  dw 140
TWO_HUNDRED_W     dw 200
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
DELETE_LAST_CHAR DB 8, ' ', 8, '$'

.tmp_word dw ?
.input_buffer db 20 dup(?)