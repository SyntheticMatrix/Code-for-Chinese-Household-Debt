function od = odebtfunc(w1_liq_next, w1_ill_next, C1_next)
od = 0.2815 * sin(w1_liq_next + w1_ill_next) + sin(C1_next) - 0.9283;
end