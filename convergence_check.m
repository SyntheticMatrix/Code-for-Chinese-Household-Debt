function [converged, periodic_indices] = convergence_check(V_history_matrix, V1_interp, V1, window_size, tol)
    num_groups = size(V1, 1);  % 假设 V1 的每一行代表一个组
    converged = false;         % 默认情况下未收敛
    periodic_indices = false(num_groups, 1);  % 记录周期性收敛的组
    tol = 1e-5;
    for i = 1:num_groups
        % 获取当前组的历史记录
        V_history = V_history_matrix(i, :);
        
        % 判断当前组是否周期性收敛
        periodic = is_periodic_with_fft(V_history, window_size);
        
        if periodic == true
            % 如果该组周期性收敛，则标记并跳过差值检测
            periodic_indices(i) = true;
        else
            % 如果不周期性收敛，则检测差值
            if max(abs(real(V1_interp(i, :)) - real(V1(i, :)))) < tol
                % 如果差值小于 tol，则标记该组收敛
                periodic_indices(i) = true;
            end
        end
    end

    % 如果所有组都满足周期性收敛或差值检测，则判断整体收敛
    if all(periodic_indices)
        converged = true;
    end
    % 输出哪些个体具有周期性震荡
    if ~isempty(periodic_indices)
        fprintf('Individuals with periodic behavior: %s\n', mat2str(periodic_indices));
    end
    
    % 如果所有非周期性个体都满足收敛条件，则返回converged = true
end
