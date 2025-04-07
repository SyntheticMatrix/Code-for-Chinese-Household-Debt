function g_rate1 = calculate_evolution_rate1(V1_interp, w1_liq, w1_ill, y1, t, w1_liq_next, w1_ill_next, y1_next, V1_plus, V1_minus, V11_plus, V11_minus)
    % 计算价值函数对各个变量的偏导数
   % dV_dw1_liq = gradient(V1_interp, w1_liq);  % 可流动财富对价值函数的偏导数
   % dV_dw1_ill = gradient(V1_interp, w1_ill);  % 不可流动财富对价值函数的偏导数
   % dV_dy1 = gradient(V1_interp, y1);          % 股权收入对价值函数的偏导数
   
% 差分间距
delta_w1 = 2;

% 使用中心差分法计算对 w1_liq 的偏导数
dV_dw1_liq = (V1_plus - V1_minus) / ( delta_w1);

% 使用中心差分法计算对 w1_liq 的偏导数
dV_dw1_ill = (V11_plus - V11_minus) / ( delta_w1);

disp('D1:');
        disp(num2str(dV_dw1_liq'));
        disp('D1:');
        disp(num2str(dV_dw1_ill'));
    % 计算各个状态变量的变化率
    dw1_liq_dt = (w1_liq_next - w1_liq) / 2;  % 可流动财富的变化率
    dw1_ill_dt = (w1_ill_next - w1_ill) /2;  % 不可流动财富的变化率
    dy1_dt = (y1_next - y1) / 1;              % 股权收入的变化率

    % 计算演化速率
    g_rate1 = dV_dw1_liq .* dw1_liq_dt + dV_dw1_ill .* dw1_ill_dt;
    
    %g_rate1 =  dw1_liq_dt + dw1_ill_dt + dy1_dt;
    
    % 防止INF和NAN，进行归一化处理
     g_rate1 = 1* g_rate1; % 归一化
     g_rate1(isnan(g_rate1)) = 0.0001;
     insane_g_rate = find(g_rate1 > 0.0001);  % 查找所有大于 0.1 的索引

if ~isempty(insane_g_rate)  % 检查 insane_g_rate 是否为空
    for i = 1:length(insane_g_rate)
        index = insane_g_rate(i);
        g_rate1(index) = 0.0001;  % 将值大于 0.1 的元素替换为 0.1
    end
end
end
