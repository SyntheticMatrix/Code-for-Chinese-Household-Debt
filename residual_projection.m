%% 残差计算函数
function res = residual_projection(Theta, nodes, orders, b_min, b_max, lambda)
    % 参数分解
% 参数分解
    theta_c = Theta(1:orders.c + 1);          % 4×1
    theta_d = Theta(orders.c + 2:orders.c + 1 + orders.d + 1); % 4×1
    theta_b = Theta(orders.c + orders.d + 3:end); % 4×1
    
    % 生成基矩阵
    Phi_c = build_basis_matrix(nodes, orders.c, [b_min, b_max]);
    Phi_d = build_basis_matrix(nodes, orders.d, [b_min, b_max]);
    Phi_b = build_basis_matrix(nodes, orders.b, [b_min, b_max]);
    
    % 计算策略函数
    c = Phi_c * theta_c;    % 消费策略
    d = Phi_d * theta_d;    % 债务策略
    b_next = Phi_b * theta_b; % 下期财富
    
    % 动态方程残差：b_next = (1 + rb_ss)b - c - d （rb_ss=0.01）
    target_b_next = (1 + 0.01) * nodes - c - d;
    residual = b_next - target_b_next;
    
    % 正则化项
    regularization = lambda * sum(Theta.^2);
    
    % 总残差
    res = sum(residual.^2) + regularization;
end