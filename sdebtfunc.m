function d = sdebtfunc(dd, C, w_liq)
d = 0.0425 *dd + 0.2*(C - w_liq);
end