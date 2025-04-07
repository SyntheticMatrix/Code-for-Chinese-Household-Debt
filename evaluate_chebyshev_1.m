function C1_next_value = evaluate_chebyshev_1(C1_interp_coeff, C1, a, b)
    degree = length(C1_interp_coeff) - 1;
    n = length(C1);
    C1_next_value = zeros(n, 1);
    a = 0.01; b=1;
    C1_normalized = (C1 - min(C1)) / (max(C1) - min(C1));
    
    for i = 1:n
        
        x = C1_normalized(i);
        tau = 2 * (x - a) / (b - a) - 1;
        
       
        T = zeros(degree + 1, 1);
        T(1) = 1;
        if degree >= 1
            T(2) = tau;
        end
        for j = 3:degree + 1
            T(j) = 2 * tau * T(j-1) - T(j-2);
        end
        
      
        C1_next_value(i) = sum(C1_interp_coeff .* T);
    end
    
  
    C1_next_value = 0.01 + (C1_next_value - min(C1_next_value)) * (1 - 0.01) / (max(C1_next_value) - min(C1_next_value));
end