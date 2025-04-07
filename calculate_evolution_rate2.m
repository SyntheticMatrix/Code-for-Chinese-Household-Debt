function g_rate2 = calculate_evolution_rate1(V2_interp, w2_liq, w2_ill, y2, t, w2_liq_next, w2_ill_next, y2_next, V2_plus, V2_minus, V22_plus, V22_minus)
    % 计算价值函数对各个变量的偏导数
   % dV_dw1_liq = gradient(V1_interp, w1_liq);  % 可流动财富对价值函数的偏导数
   % dV_dw1_ill = gradient(V1_interp, w1_ill);  % 不可流动财富对价值函数的偏导数
   % dV_dy1 = gradient(V1_interp, y1);          % 股权收入对价值函数的偏导数
   
% 差分间距
delta_w1 = 2;

% 使用中心差分法计算对 w1_liq 的偏导数
dV_dw2_liq = (V2_plus - V2_minus) / ( delta_w1);

% 使用中心差分法计算对 w1_liq 的偏导数
dV_dw2_ill = (V22_plus - V22_minus) / ( delta_w1);


    % 计算各个状态变量的变化率
    dw2_liq_dt = (w2_liq_next - w2_liq) / 2;  % 可流动财富的变化率
    dw2_ill_dt = (w2_ill_next - w2_ill) / 2;  % 不可流动财富的变化率
    dy2_dt = (y2_next - y2) / 1;              % 股权收入的变化率

    % 计算演化速率
    g_rate2 = dV_dw2_liq .* dw2_liq_dt + dV_dw2_ill .* dw2_ill_dt;
    
    %g_rate1 =  dw1_liq_dt + dw1_ill_dt + dy1_dt;
    
    % 防止INF和NAN，进行归一化处理
     g_rate2 = 1* g_rate2; % 归一化
     g_rate2(isnan(g_rate2)) = 0.001;
   
end
