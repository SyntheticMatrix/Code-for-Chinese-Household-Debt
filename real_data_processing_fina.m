%%  

total_families = length(Ill);  
% Calculate the target number for the top 20% and the bottom 80%  
target_20 = round(0.2 * total_families);  
target_80 = total_families - target_20;  
% If there is a remainder, we need to balance the adjustment  
extra = total_families - (target_20 + target_80);  
front_adjust = floor(extra / 2);  % Number of families removed from the front  
back_adjust = extra - front_adjust;  % Number of families removed from the back  

% Update the actual indices for the top 20% and the bottom 80%  
actual_20 = target_20 + front_adjust;  
actual_80_start = actual_20 + 1;  
actual_80_end = total_families - back_adjust;  
% Grouping  
group_20 = Liq(1:actual_20); % Top 20% of families  
group_80 = Liq(actual_80_start:actual_80_end); % Bottom 80% of families  

% Output check  
fprintf('Number of families in the top 20%%: %d\n', length(group_20));  
fprintf('Number of families in the bottom 80%%: %d\n', length(group_80));  

%%  

% Assume that wealth is already sorted in ascending order and has been divided into the top 20% and bottom 80%  
% If using the variables from the previous section:  
% group_20: Wealth vector of the top 20% of families  
% group_80: Wealth vector of the bottom 80% of families  

% Number of groups  
num_groups = 400;  

% Grouping the top 20% of families  
num_20 = length(group_20);  
group_20_size = floor(num_20 / num_groups);  % Number of families per group  

% If it divides evenly, group directly; otherwise, handle the remaining families at the end  
extra_20 = num_20 - group_20_size * num_groups;  % Extra families  
group_20_avg_Liq = zeros(num_groups, 1);  % Store the average wealth of each group  

% Divide into 400 groups and compute the average wealth for each group  
for i = 1:num_groups  
    start_idx = (i - 1) * group_20_size + 1;  
    end_idx = i * group_20_size;  

    % Handle the remaining families at the end  
    if i <= extra_20  
        end_idx = end_idx + 1;  
    end  

    % Compute the average wealth of each group  
    group_20_avg_Liq(i) = mean(group_20(start_idx:end_idx));  
end  

% Grouping the bottom 80% of families  
num_80 = length(group_80);  
group_80_size = floor(num_80 / num_groups);  % Number of families per group  

% If it divides evenly, group directly; otherwise, handle the remaining families at the end  
extra_80 = num_80 - group_80_size * num_groups;  % Extra families  
group_80_avg_Liq = zeros(num_groups, 1);  % Store the average wealth of each group  

% Divide into 400 groups and compute the average wealth for each group  
for i = 1:num_groups  
    start_idx = (i - 1) * group_80_size + 1;  
    end_idx = i * group_80_size;  

    % Handle the remaining families at the end  
    if i <= extra_80  
        end_idx = end_idx + 1;  
    end  

    % Compute the average wealth of each group  
    group_80_avg_Liq(i) = mean(group_80(start_idx:end_idx));  
end  

% Output check  
fprintf('Size of the average wealth vector for the top 20%% groups: %d x 1\n', length(group_20_avg_Liq));  
fprintf('Size of the average wealth vector for the bottom 80%% groups: %d x 1\n', length(group_80_avg_Liq));  

%%  

% Assume the variables for income, consumption, and assets are income, consumption, and assets, respectively  
epsilon = 1e-6; % To avoid issues with log transformation of zero values  
w1_liq_real = log(group_20_avg_Liq + 1 + epsilon);  
w2_liq_real = log(group_80_avg_Liq + 1 + epsilon);  
