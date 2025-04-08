%% Chebyshev基函数生成（含区间缩放）
function Phi = build_basis_matrix(x, order, interval)
    % 将x缩放到[-1,1]
    x_scaled = 2*(x - interval(1))/(interval(2) - interval(1)) - 1;
    
    % 生成基函数矩阵
    Phi = zeros(length(x), order+1);
    for k = 0:order
        Phi(:,k+1) = cos(k * acos(x_scaled));
    end
end