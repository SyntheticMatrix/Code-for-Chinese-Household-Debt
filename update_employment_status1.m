% 更新失业状态
function employment_status1 = update_employment_status1(current_status1, P_unemployment1)
    % current_status1: 当前的就业状态向量，0表示失业，1表示就业
    % P_unemployment1: 转移矩阵

    % 初始化输出向量
   % employment_status1 = zeros(size(current_status1));  % 保持维度

    % 遍历每个个体的状态
    for i = 1:length(current_status1)
        if current_status1(i) == 0  % 当前失业
            transition_prob = rand();  % 生成一个随机数
            if transition_prob < P_unemployment1(1, 2)
                employment_status1(i) = 1;  % 切换为就业
            else
                employment_status1(i) = 0;  % 保持失业
            end
        else  % 当前就业
            transition_prob = rand();  % 生成一个随机数
            if transition_prob < P_unemployment1(2, 1)
                employment_status1(i) = 0;  % 切换为失业
            else
                employment_status1(i) = 1;  % 保持就业
            end
        end
    end
     % 确保输出仍然为列向量
    employment_status1 = employment_status1(:);  % 强制转为列向量
end

