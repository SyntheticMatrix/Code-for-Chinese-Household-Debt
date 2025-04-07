function P_unemployment1 = kolmogorov_equation1(P_unemployment1, g_rate1, employment_status1, n_points)
    % P_unemployment: 失业率转移矩阵
    % g_rate: 计算得到的速率变化
    % employment_status: 当前就业状态
    % n_points: 消费者数量
    % total_steps: 时间步数

    % 初始化Kolmogorov方程的状态变化矩阵
    dP = zeros(2, 1); % 2个状态：失业和就业

    % 计算每个状态的变化
    for i = 1:n_points
        % 当前状态
        if employment_status1(i) == 0 % 失业
            dP(1) = dP(1) + g_rate1(i)/400 ; % 失业状态
            dP(2) = dP(2) - g_rate1(i)/400 ; % 就业状态
        else % 就业
            dP(1) = dP(1) - g_rate1(i)/400 ; % 失业状态
            dP(2) = dP(2) + g_rate1(i)/400 ; % 就业状态
        end
    end

    % 更新转移矩阵
    P_unemployment1 = P_unemployment1 + dP;

    % 输出新的转移矩阵
    disp('更新后的失业率转移矩阵：');
    disp(P_unemployment1);
end

% 示例调用
%n_points = 400; % 例如400个个体
%total_steps = 1000; % 例如1000个时间步
%kolmogorov_equation(P_unemployment, g_rate, employment_status, n_points, total_steps);
