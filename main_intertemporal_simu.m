% HJB 

% param(Block 1)
params = struct();
params.r = 0.03 ;              % 
params.r_ill = 0.04;          % 
params.depreciation_rate = 0.02;  % 
params.alpha = 0.3;             % 
params.beta = 0.02 ;           % 
params.D_max = 2;             % 
params.max_iter = 10000000;       % 
params.num_individuals = 400; % 
params.t_max = 20;          % 
params.gamma = 0.03;
params.mpc_base = 0.5;
mpc_base2 = 0.5;
K = 4;
P_UU = 0.7;
P_UE = 0.3;
P_EU = 0.02;
P_EE = 0.98;
[P_unemployment1, P_unemployment2] = define_unemployment_matrix(P_UU, P_UE, P_EU, P_EE);
n_points = 400;
lambda = 0.5;
gamma1 = 0.6;
delta_t = 1;
rho= 0.005;
delta_w1 = 0.1;
alpha_liq = 0.95;  % 
alpha_ill = 0.95;  % 

w1_liq_lower_bound = 2;  %
w2_liq_lower_bound = 2;
chi_0 = 0.03;  % 
chi_1 = 0.02;  %
% 
p_purchase = 0.05;  % 
p_no_action = 0.9;  % 
p_sell = 0.05;  % 
D = D1_real;
D2 = D2_real;
current_status1 = ones(n_points, 1); % 
current_status2 = ones(n_points, 1);
employment_status1 = zeros(n_points, 1);
employment_status2 = zeros(n_points, 1);
C1 = C1_real;
C2 = C2_real;
w1_liq = w1_liq_real;
transfer_count = zeros(400,1);  % 
transfer_count2 = zeros(400,1);
T = zeros(400,1);  % 
T2 = zeros(400,1);

w1_ill = w1_ill_real;

y1 = 0.75 * ones(params.num_individuals, 1);      
w2_liq = w2_liq_real;
w2_ill = w2_ill_real;  
y2 = 1 * ones(params.num_individuals, 1);     
V1 = 1 * ones(params.num_individuals, 1);  
V2 = 1 * ones(params.num_individuals, 1);  

grid_points_liq = linspace(min(w1_liq)-1 , max(w1_liq) +5 , n_points);  % 创建网格点
grid_points_ill = linspace(min(w1_ill) -1, max(w1_ill) +5 , n_points);
grid_points_liq2 = linspace(min(w2_liq)-1 , max(w2_liq) +5 , n_points);  % 创建网格点
grid_points_ill2 = linspace(min(w2_ill) -1, max(w2_ill) +5 , n_points);

disp(['grid_points_liq: ', num2str(grid_points_liq)]);
disp(['grid_points_ill: ', num2str(grid_points_ill)]);
min_value = min(w1_ill);
max_value = max(w1_ill);
for i = 1:400
    row_min = min_value + (i-1) * (max_value - min_value) / 400;
    row_max = min_value + i * (max_value - min_value) / 400;
    V1_grid(i, :) = linspace(row_min, row_max, 400);
end

V2_grid =  randn(n_points, n_points);  
V2_grid = smoothdata(V2_grid, 'gaussian');  
min_value = -1;         
max_value = 1;      
num_points = 400;     

 if length(grid_points_liq) < 2 || length(grid_points_ill) < 2
        error('only one point in grid');
 end
window_size = 100;
V_history_matrix = zeros(400, window_size);  % 
V_history_matrix2 = zeros(400, window_size);  % 
current_index = 1;         % 
W1_liq_matrix = zeros(400, 100);
W1_ill_matrix = zeros(400, 100);
C1_matrix = zeros(400, 100);
mpc_matrix = zeros(400,100);
D_matrix = zeros(400, 100);
W2_liq_matrix = zeros(400, 100);
W2_ill_matrix = zeros(400, 100);
C2_matrix = zeros(400, 100);
mpc_matrix2 = zeros(400,100);
D2_matrix = zeros(400, 100);
d_bar = zeros(400, 100);
d_min = zeros(400, 100);
theta = 1;
n_points = 400;
n = 10;
Fs = 1000;                        
window_size = 100;       
C1_interp_coeff = precompute_chebyshev_1(C1, n_points, K); 
C2_interp_coeff = precompute_chebyshev_1(C2, n_points, K);
% iteration (Block 3)
tol = 1e-6;    
for t = 1:params.t_max
   
        % Consumption dynamic and wealth accumulation
        
        mpc_dynamic = (C1 ./(w1_liq + w1_liq));  % mpc
        mpc_dynamic = max(0.3, mpc_dynamic);
        
        % type 2
        
        mpc_dynamic2 = (C2./(w2_liq + w2_ill));
        mpc_dynamic2 = max(0.3, mpc_dynamic2);
        
     
          liq_change_limit = 0.1 * w1_liq;
          ill_change_limit = 0.1 * w1_ill;  

        
w1_liq_next = w1_liq * 1.01 - C1 + y1 - D;

w2_liq_next = w2_liq * 1.01 - C2 + y2 - D2;

w1_ill_next= (1 + params.r_ill)* w1_ill;
w2_ill_next = (1 + params.r_ill) * w2_ill;

threshold = 0.01;  
transfer_amount = 0.01;  

negative_indices = find(w1_liq_next < threshold);

for i = 1:length(negative_indices)
    index = negative_indices(i);
    
    while w1_liq_next(index) < threshold
        if w1_ill_next(index) > 0.01  
            
            w1_liq_next(index) = w1_liq_next(index) + transfer_amount;
            w1_ill_next(index) = w1_ill_next(index) -  0.2*transfer_amount;
       
            transfer_count(index) = transfer_count(index) + 1;
            T(index) = T(index) + transfer_amount;
        else
            
            w1_liq_next(index) = w1_liq_next(index) + w1_ill_next(index)-0.1;
            w1_ill_next(index) = 0.1;  
            break;  
        end
        
      
        if w1_liq_next(index) >= 0.1
            break;  
        end
    end
end
% stochastic
remaining_indices = setdiff(1:length(w1_liq_next), negative_indices);


p = 0.3;  
q = 0.2;  
mu = 0.072;  % transfer mean


transfer_amounts = exprnd(mu, 1, length(remaining_indices));


for i = 1:length(remaining_indices)
    index = remaining_indices(i);
    rand_val = rand();
    current_transfer = transfer_amounts(i);
    
    if rand_val < p
        % sale
        illiquid_available = w1_ill_next(index) - 0.1;  
        if illiquid_available > current_transfer
           
            w1_liq_next(index) = w1_liq_next(index) + current_transfer;
            w1_ill_next(index) = w1_ill_next(index) - current_transfer;
        else
            
            w1_liq_next(index) = w1_liq_next(index) + illiquid_available;
            w1_ill_next(index) = 0.1;
            current_transfer = illiquid_available;
        end
        transfer_count(index) = transfer_count(index) + 1;
        T(index) = T(index) + current_transfer;
        
    elseif rand_val < p + q
        % purchase
        if w1_liq_next(index) > current_transfer
            w1_liq_next(index) = w1_liq_next(index) - current_transfer;
            w1_ill_next(index) = w1_ill_next(index) + current_transfer;
            transfer_count(index) = transfer_count(index) + 1;
            T(index) = T(index) + current_transfer;
        end
    end
    
end

% 
w1_liq_next(w1_liq_next < 0) = 0;
w1_ill_next(w1_ill_next < 0.1) = 0.1;
five_indices = find(w2_liq_next <1);

for i = 1:length(five_indices)
    index = five_indices(i);
    
    while w2_liq_next(index) < 1
        if w2_ill_next(index) > 0  % 确保非流动资产大于0
            % 进行转移
            w2_liq_next(index) = w2_liq_next(index) + transfer_amount;
            w2_ill_next(index) = w2_ill_next(index) - 0.2*transfer_amount;
        else
            % 如果非流动资产为0，直接转移所有可能的资产
            w2_liq_next(index) = w2_liq_next(index) + w2_ill_next(index)-0.1;
            w2_ill_next(index) = 0.1;  % 将非流动资产清零
            % 更新转移次数
            transfer_count2(index) = transfer_count2(index) + 1;
            T2(index) = T2(index) + transfer_amount;
            break;  % 结束循环
        end
        
        % 检查转移后是否已经满足条件
        if w2_liq_next(index) >= 1
            break;  % 满足条件，退出循环
        end
    end
end

% 标记剩余家庭（未触发阈值调整的家庭）
remaining_indices2 = setdiff(1:length(w2_liq_next), negative_indices);

% 定义转移支付概率参数（示例值，可根据需要调整）
p = 0.05;  % 变卖概率
q = 0.2;  % 购买概率
mu = 0.072;  % 转移支付量均值

% 为剩余家庭创建转移支付量（指数分布示例）
transfer_amounts2 = exprnd(mu, 1, length(remaining_indices2));

% 处理剩余家庭的转移支付
for i = 1:length(remaining_indices2)
    index = remaining_indices2(i);
    rand_val = rand();
    current_transfer2 = transfer_amounts2(i);
    
    if rand_val < p
        % 变卖不可流动资产
        illiquid_available = w2_ill_next(index) - 0.1;  % 保持最低非流动资产
        if illiquid_available > current_transfer2
            % 正常转移
            w2_liq_next(index) = w2_liq_next(index) + current_transfer2;
            w2_ill_next(index) = w2_ill_next(index) - 0.2*current_transfer2;
        else
            % 转移全部可用非流动资产
            w2_liq_next(index) = w2_liq_next(index) + illiquid_available;
            w2_ill_next(index) = 0.1;
            current_transfer2 = illiquid_available;
        end
        transfer_count2(index) = transfer_count2(index) + 1;
        T2(index) = T2(index) + current_transfer2;
        
    elseif rand_val < p + q
        % 购买不可流动资产
        if w2_liq_next(index) > current_transfer2
            w2_liq_next(index) = w2_liq_next(index) - current_transfer2;
            w2_ill_next(index) = w2_ill_next(index) + 0.2*current_transfer2;
            transfer_count2(index) = transfer_count2(index) + 1;
            T2(index) = T2(index) + current_transfer2;
        end
    end
    
    % 记录转移类型（可选）
    % transfer_type(index) = 根据操作类型标记（例如1-变卖，2-购买，0-无操作）
end
 

    % 计算调整成本
adjustment_cost = chi_0 + chi_1 * abs(T ./ max(w1_liq_next, w1_liq_lower_bound));
adjustment_cost2 = chi_0 + chi_1 * abs(T2./ max(w2_liq_next, w2_liq_lower_bound));
% 更新后的流动资产（扣除调整成本）
%w1_liq_next = w1_liq_next + 0.9 * w1_ill ;
% 计算更新后的非流动资产

    w1_liq_next = real(w1_liq_next - adjustment_cost);
    w1_liq_next = min(20, max(-1, w1_liq_next));
    
    w2_liq_next = w2_liq_next - adjustment_cost2;
    w2_liq_next = min(20, max(-1, w2_liq_next));

        w1_ill_next = max(0, min(20, w1_ill_next));
        %w2_ill_next = max(0, min(20, w2_ill_next));
        % 消费路径更新（欧拉方程逼近 + 插值修正）
       % C1_next = min(1, max(0.01, 0.98 * ((evaluate_chebyshev(C1_interp_coeff, C1) + mpc_dynamic .* w1_liq_next))));
        C1_growth_factor = (1 + mpc_dynamic);  % 考虑到下一期的边际消费倾向和流动资产
C1_cheby = evaluate_chebyshev_1(C1_interp_coeff, C1);
C2_growth_factor = (1 + mpc_dynamic2);
C2_cheby = evaluate_chebyshev_1(C2_interp_coeff, C2);
% 利用欧拉方程修正消费路径，平滑消费变化
C1_next =  C1_cheby .* (C1_growth_factor / (1 + rho * delta_t)) .^ (1/gamma1) ; 
C2_next = C2_cheby.* (C2_growth_factor/(1 + rho * delta_t)).^(1/gamma1) ;

% 使用合理的上下限
%C1_next = min(1, max(0.01, C1_next));
%C2_next = min(2, max(0.01+abs(randn * 0.1), C2_next));
       % D = (C1_next - w1_liq_next) + 0.5 * sin(2 * pi * t / 100) + 0.001 * abs(randn);
        %D = 0.0425 *D + 0.5*(C1_next - w1_liq_next);
       % D_f = fft(D);  % 傅立叶变换处理
       % D = real(D_f);
       % D = max(-0.1, min(D, params.D_max));  % 限制借贷
       % D = 0.75 * D;
       % D = 0.2815 * sin(w1_liq_next + w1_ill_next) + sin(C1_next) - 0.09283;
       D = odebtfunc(w1_liq_next, w1_ill_next, C1_next);
     %D = max(0, min(D, params.D_max));
      %  D2 = 0.0425*D2 + 0.5* (C2_next - w2_liq_next);
        D2 = odebtfunc(w2_liq_next, w2_ill_next, C2_next);
        D2 = max(0, min(D2, params.D_max * 2)) ;
        
        employment_status1 = update_employment_status1(current_status1, P_unemployment1);  % 简化假设，90%就业率
        y1_next = employment_status1 .* (params.alpha + params.beta * y1 * 1.02) + ~employment_status1 * 0.01;
        
        employment_status2 = update_employment_status1(current_status2, P_unemployment2);
        y2_next = employment_status2 .* (params.alpha + params.beta * y2 * 1.02) + ~employment_status2 * 0.01;
        
       
        % 将更新后的值写回
       
        
    
        V_liq =w1_liq_next;
        V_ill = w1_ill_next;
        V_ill = real(V_ill);
        V_liq = real(V_liq);
        
        V_liq2 = w2_liq_next;
        V_ill2 =  w2_ill_next;
        V_liq2 = real(V_liq2);
        V_ill2 = real(V_ill2);
       
         % 资产更新：基于Young插值进行优化
        
       V1_interp =  interpolate_V1(V1_grid, grid_points_liq, grid_points_ill, V_liq, V_ill, w1_liq, w1_ill);  % 插值计算V1
       V2_interp = interpolate_V1(V2_grid, grid_points_liq2, grid_points_ill2, V_liq2, V_ill2, w2_liq, w2_ill);
     for iter = 1:params.max_iter
        fprintf('Time step: %d, Iteration: %d\n', t, iter); % 输出迭代进度
       V1_interp = log(C1+1) + 0.98 * V1_interp;
        V1_interp(isnan(V1_interp)) = 0.1;
        
        disp('V1_interp:');
        disp(num2str(V1_interp'));  % 逐行显示 V1_interp
        
        V2_interp = log(C2+1) +0.98 * V2_interp;
        V2_interp(isnan(V2_interp)) = 0.1;
        
        disp('V2_interp:');
        disp(num2str(V2_interp'));
        
       
        %disp(evaluate_chebyshev(C1_interp_coeff, C1));  % 打印 Chebyshev 插值结果
        %disp(mpc_dynamic);  % 打印边际消费倾向
        diff = max(abs(V1_interp - V1));
        disp('diff:');
        disp(num2str(diff));
        diff2 = max(abs(V2_interp - V2));
        disp('diff2:');
        disp(num2str(diff2));
        if diff < tol && diff2 <tol
        %if converged
             fprintf('Converged at time step: %d, iteration: %d\n', t, iter);
            break;
        end
        %V1 = V1_interp;
        V1 = (1 - lambda) * V1 + lambda * V1_interp;  % lambda 从 0.5 开始逐步减小
        V2 = (1 - lambda) * V2 + lambda * V2_interp;
     end
        %时间步外循环 求解转移矩阵变化 更新变量
        V11_plus = interpolate_V1(V1_grid, grid_points_liq, grid_points_ill, V_liq, V_ill, w1_liq , w1_ill + delta_w1);

        % 插值计算在 w1 - delta_w1 处的 V1 值
        V11_minus = interpolate_V1(V1_grid, grid_points_liq, grid_points_ill, V_liq, V_ill, w1_liq, w1_ill - delta_w1);
        % 插值计算在 w1 + delta_w1 处的 V1 值
        V1_plus = interpolate_V1(V1_grid, grid_points_liq, grid_points_ill, V_liq, V_ill, w1_liq + delta_w1, w1_ill);

        % 插值计算在 w1 - delta_w1 处的 V1 值
        V1_minus = interpolate_V1(V1_grid, grid_points_liq, grid_points_ill, V_liq, V_ill, w1_liq - delta_w1, w1_ill);
        V22_plus = interpolate_V1(V1_grid, grid_points_liq2, grid_points_ill2, V_liq2, V_ill2, w2_liq , w2_ill + delta_w1);

        % 插值计算在 w1 - delta_w1 处的 V1 值
        V22_minus = interpolate_V1(V1_grid, grid_points_liq2, grid_points_ill2, V_liq2, V_ill2, w2_liq, w2_ill - delta_w1);
        % 插值计算在 w1 + delta_w1 处的 V1 值
        V2_plus = interpolate_V1(V1_grid, grid_points_liq2, grid_points_ill2, V_liq2, V_ill2, w2_liq + delta_w1, w2_ill);

        % 插值计算在 w1 - delta_w1 处的 V1 值
        V2_minus = interpolate_V1(V1_grid, grid_points_liq2, grid_points_ill2, V_liq2, V_ill2, w2_liq - delta_w1, w2_ill);
         g_rate1 = calculate_evolution_rate1(V1, w1_liq, w1_ill, y1, t, w1_liq_next, w1_ill_next, y1_next, V1_plus, V1_minus, V11_plus, V11_minus);
        g_rate2 = calculate_evolution_rate2(V2, w2_liq, w2_ill, y2, t, w2_liq_next, w2_ill_next, y2_next, V2_plus, V2_minus, V22_plus, V22_minus);
        P_unemployment1 = kolmogorov_equation1(P_unemployment1, g_rate1, employment_status1, n_points);
        P_unemployment2 = kolmogorov_equation1(P_unemployment2, g_rate2, employment_status2, n_points);
       
       
        w1_liq = w1_liq_next;
        w1_ill = w1_ill_next;
        y1 = y1_next;
        C1 = C1_next;
        w2_liq = w2_liq_next;
        w2_ill = w2_ill_next;
        y2 = y2_next;
        C2 = C2_next;
        current_status1 = employment_status1;
        current_status2 = employment_status2;
         %存储最新的 V1
    V_history_matrix(:, current_index) = V1;
    W1_liq_matrix(:, current_index) = w1_liq_next;
    W1_ill_matrix(:, current_index) = w1_ill_next;
    C1_matrix(:, current_index) = C1_next;
    mpc_matrix(:, current_index) = mpc_dynamic;
    D_matrix(: , current_index) = D;
    V_history_matrix2(:, current_index) = V2;
    W2_liq_matrix(:, current_index) = w2_liq_next;
    W2_ill_matrix(:, current_index) = w2_ill_next;
    C2_matrix(:, current_index) = C2_next;
    mpc_matrix2(:, current_index) = mpc_dynamic2;
    D2_matrix(: , current_index) = D2;
    
    d_bar = max(w1_liq_next + w1_ill_next)/50;
    d_min = min(w1_liq_next + w1_ill_next)/50;
    grid_points_liq = linspace(min(w1_liq) - 1 , max(w1_liq)+1, n_points);  % 创建网格点
    grid_points_ill = linspace(min(w1_ill)- 1, max(w1_ill)+1 , n_points);
    grid_points_liq2 = linspace(min(w2_liq)-1 , max(w2_liq) +1 , n_points);  % 创建网格点
grid_points_ill2 = linspace(min(w2_ill) -1, max(w2_ill) +1 , n_points);
   min_value = min(w1_ill);
max_value = max(w1_ill);
for i = 1:400
    row_min = min_value + (i-1) * (max_value - min_value) / 400;
    row_max = min_value + i * (max_value - min_value) / 400;
    V1_grid(i, :) = linspace(row_min, row_max, 400);
end
    [a_t, b_t] = solve_time_varying_params(n, theta, d_bar, d_min);
    ww1 = a_t + b_t * (w1_liq_next+w1_ill_next);
    %sorted_wealth_t = sort(ww1(:, t)); % 按照财富排序
    %cumulative_wealth_t = cumsum(sorted_wealth_t) / sum(sorted_wealth_t);  % 计算财富累积分布
        d_bar2 = max(w2_liq_next + w2_ill_next)/50;
    d_min2 = min(w2_liq_next + w2_ill_next)/50;
     min_value2 = min(w2_ill);
max_value2 = max(w2_ill);
for i = 1:400
    row_min2 = min_value2 + (i-1) * (max_value2 - min_value2) / 400;
    row_max2 = min_value2 + i * (max_value2 - min_value2) / 400;
    V2_grid(i, :) = linspace(row_min2, row_max2, 400);
end
    [c_t, d_t] = solve_time_varying_params(n, theta, d_bar2, d_min2);
    ww2 = c_t + d_t * (w2_liq_next+w2_ill_next);
    % 更新当前索引（循环方式）
    current_index = mod(current_index, window_size) + 1;
        
        % 判断是否周期性
       
        if t >= window_size
      [converged, periodic_indices] = convergence_check(V_history_matrix, V1_interp, V1, window_size, tol);
      [converged2, periodic_indices] = convergence_check(V_history_matrix2, V2_interp, V2, window_size, tol);
        else
            converged = false;
            converged2 = false;
        end
        if converged && converged2
            break
        end
        
end
