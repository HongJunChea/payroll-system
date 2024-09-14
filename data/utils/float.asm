; change_rounding
.old_round     DW ?
.current_round DW ?

ROUND_BANKERS DB 00000000b
ROUND_UP      DB 00001000b
ROUND_DOWN    DB 00000100b
ROUND_TO_ZERO DB 00001100b