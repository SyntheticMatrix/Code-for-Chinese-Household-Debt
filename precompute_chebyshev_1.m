function C1_interp_coeff = precompute_chebyshev_1(C1, n_points, degree)
    % 设置区间为 [0.01, 1]
    a = 0.01;
    b = 1;
    C1_normalized = (C1 - min(C1)) / (max(C1) - min(C1));
    % 生成并映射切比雪夫节点
    chebyshev_nodes_standard = cos((2*(1:n_points) - 1) * pi / (2*n_points));
    chebyshev_nodes = a + (b - a) * (chebyshev_nodes_standard + 1) / 2;
    
    % 构建切比雪夫基矩阵
    T = zeros(n_points, degree + 1);
    for k = 1:n_points
        x = chebyshev_nodes(k);
        tau = 2 * (x - a) / (b - a) - 1;  % 标准化到 [-1, 1]
        
        T(k, 1) = 1;                      % T0
        if degree >= 1
            T(k, 2) = tau;                % T1
        end
        for j = 3:degree + 1
            T(k, j) = 2 * tau * T(k, j-1) - T(k, j-2);  % Tj
        end
    end
    
    % 求解系数（最小二乘法）
    C1_sub = C1_normalized(1:n_points);
    
    % 通过正则化解决数值稳定性问题（使用岭回归方式）
    lambda = 1e-6; % 正则化参数
    C1_interp_coeff = (T' * T + lambda * eye(degree + 1)) \ (T' * C1_sub(:));
end