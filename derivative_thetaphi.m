
Phi_c_derivative = chebyshev_derivative(b_ss, orders.c, [b_min, b_max]);
Phi_d_derivative = chebyshev_derivative(b_ss, orders.d, [b_min, b_max]);

dc_db = Phi_c_derivative* theta_c;  
dd_db = Phi_d_derivative* theta_d;  