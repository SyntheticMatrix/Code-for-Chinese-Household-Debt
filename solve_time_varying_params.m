function [a_t, b_t] = solve_time_varying_params(n, theta, d_bar, d_min)
    % 定义初始猜测值
    initial_guess = [0.5, 0.5]; % 对于 a_t 和 b_t 的初始猜测
    
    % 使用 fsolve 求解方程
    options = optimoptions('fsolve', 'Display', 'iter'); % 设置 fsolve 选项，显示迭代信息
    [params, fval, exitflag] = fsolve(@(x) n_equations(x, n, theta, d_bar, d_min), initial_guess, options);
    
    % 提取解
    a_t = params(1);
    b_t = params(2);
    
    % 输出解
    fprintf('Solution: a_t = %f, b_t = %f\n', a_t, b_t);
end

