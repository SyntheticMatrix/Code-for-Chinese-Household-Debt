function sa = driftilliquid_1(d, a, state_vec, par)
    % 状态参数解析
    z_income = state_vec(1);
    z_rh = state_vec(3);  % 注意索引位置
    
    % 状态依赖回报率
    ra = par.ra * (1 + z_rh);
    
    % 状态依赖收入
    income = par.xi .* par.wa .* z_income;
    
    % 漂移计算
    sa = ra .* a  + d ;
end