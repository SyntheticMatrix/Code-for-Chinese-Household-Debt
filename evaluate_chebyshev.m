function C1_next_value = evaluate_chebyshev(C1_interp_coeff, C1)
    % Evaluates function values on the consumption path C1 using Chebyshev interpolation coefficients
    % C1_interp_coeff: Chebyshev interpolation coefficients
    % C1: Current consumption path

    % Step 1: Get interpolation degree
    degree = length(C1_interp_coeff) - 1;
    C1_next_value = ones(400, 1);
    upper_bound = 1;
    lower_bound = 0.01;

    % Step 2: Map C1 to interval [-1, 1]
    % Assuming original domain of C1 is [lower_bound, upper_bound]
    C1_normalized = 2 * (C1 - lower_bound) / (upper_bound - lower_bound) - 1;

    % Step 3: Compute Chebyshev polynomial values
    T = zeros(degree + 1, 1);
    for i = 1:400
        T(1) = 1;  % T0(C1) = 1
        if degree > 0
            T(2) = C1_normalized(i);  % T1(C1) = C1
        end

        % Recursively compute Chebyshev polynomials Tn(C1)
        for j = 3:degree + 1
            T(j) = 2 * C1_normalized(i) * T(j - 1) - T(j - 2);
        end

        % Step 4: Weight Chebyshev polynomial values with coefficients
        C1_next_value(i) = sum(C1_interp_coeff' .* T);
        
        % Map results back to original interval
        C1_next_value(i) = max(min(C1_next_value(i), upper_bound), lower_bound);
    end
end
