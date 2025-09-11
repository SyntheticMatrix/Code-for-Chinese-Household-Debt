function sb = driftLiquid_1(c, d, b, a, state_vec, par)
    % 状态参数解析
    z_income = state_vec(1);
    z_rf = 0.4;
    
    % 状态依赖回报率
    Rb_base = par.rb_pos.*(b>0) + par.rb_neg.*(b<0);
    Rb = Rb_base .* (1 + z_rf);
    
    % 状态依赖收入
    income = par.xi .* par.w .* z_income;
    
    % 漂移计算
    sb = Rb .* b - d - adjustmentCost(d, a, par.chi0, par.chi1)...
         - c + income;
end