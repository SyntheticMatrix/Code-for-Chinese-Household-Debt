% 定义失业率转移矩阵
function [P_unemployment1, P_unemployment2] = define_unemployment_matrix(P_UU, P_UE, P_EU, P_EE)
    % P_UU: 失业继续失业的概率
    % P_UE: 失业找到工作的概率
    % P_EU: 就业失业的概率
    % P_EE: 就业继续就业的概率
    P_unemployment1 = [P_UU, P_UE; P_EU, P_EE];
    P_unemployment2= [P_UU, P_UE; P_EU, P_EE];
end
