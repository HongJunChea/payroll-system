; change_rounding
.old_round     DW ?
.current_round DW ?

.round_bankers DB 00000000b
.round_up      DB 00001000b
.round_down    DB 00000100b
.round_to_zero DB 00001100b