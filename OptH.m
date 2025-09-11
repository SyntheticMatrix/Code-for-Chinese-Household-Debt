function hh = OptH(V, w, par)
hh = ((V.*w).^(-1/par.eta));
end