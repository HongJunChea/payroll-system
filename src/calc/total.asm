calculate_total proc

    call calculate_basic
    call calculate_ot
    call calculate_ph

    fsum 3
    fst .emp_perf_earn_total_tmp

    call calculate_socso
    call calculate_epf
    call calculate_eis

    fsum 3

    fsubp st(1), st(0)

    ret

calculate_total endp