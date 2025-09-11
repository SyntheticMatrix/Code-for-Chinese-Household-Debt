function [g, dadbdz] = stationaryDistribution1(A, a, b, par, type)
    if nargin < 5
        type = 'measure';
    end

    I = par.I; J = par.J; Nz = par.Nz; M = I*J*8;
    
    % === 新增：检查A矩阵维度 ===
    if size(A,1) ~= M || size(A,2) ~= M
        error('A矩阵应为%d×%d，实际为%d×%d', M, M, size(A,1), size(A,2));
    end

    % 计算da, db（保持不变）
    db = compute_db(b, par);
    da = compute_da(a);
    dadbdz = repmat(db * da', 1,1,Nz);

    % === 关键修改：计算全局索引iFix ===
    % 选择z的中间层（示例取k_fix=1，可调整）
    k_fix = 1; 
    % 在a-b平面选中心点 (i_fix, j_fix)
    i_fix = round(I/2); % b维度中心
    j_fix = round(J/2); % a维度中心
    % 计算全局索引: (i-1)*J*Nz + (j-1)*Nz + k
    iFix = (i_fix-1)*J*Nz + (j_fix-1)*Nz + k_fix;

    % 构建线性系统
    vec = zeros(M,1);
    vec(iFix) = 1e-8;  % 扰动值
    AT = A';
    
    % 创建修正行（直接操作稀疏矩阵更高效）
    [~, cols] = size(AT);
    rowVec = sparse(1, iFix, 1, 1, cols); % 行为1，列为iFix的位置=1
    AT(iFix, :) = rowVec;

    % 求解并归一化
    g_stacked = AT \ vec;
    g = reshape(g_stacked / sum(g_stacked), I, J, Nz);

    if type == "density" % 推荐使用字符串比较
        g = g ./ dadbdz;
    end
end

% 辅助函数：计算db
function db = compute_db(b, par)
    I = numel(b);
    db = zeros(I,1);
    db(2:I-1) = (b(3:I) - b(1:I-2))/2;
    db(1) = (b(2) - b(1))/2;
    db(I) = (b(I) - b(I-1))/2;
    assert(abs(sum(db) - (par.bmax - par.bmin)) < 1e-10, 'db范围错误');
end

% 辅助函数：计算da
function da = compute_da(a)
    J = numel(a);
    da = zeros(J,1);
    da(2:J-1) = (a(3:J) - a(1:J-2))/2;
    da(1) = (a(2) - a(1))/2;
    da(J) = (a(J) - a(J-1))/2;
end