%% 

total_families = length(Ill);
% Calculate the target number for the top 20% and bottom 80%
target_20 = round(0.2 * total_families);
target_80 = total_families - target_20;
% If not divisible exactly, we need to adjust for balance
extra = total_families - (target_20 + target_80);
front_adjust = floor(extra / 2);  % Number of families removed from the front
back_adjust = extra - front_adjust;  % Number of families removed from the back

% Update actual indices for the top 20% and bottom 80%
actual_20 = target_20 + front_adjust;
actual_80_start = actual_20 + 1;
actual_80_end = total_families - back_adjust;
% Grouping
group_20 = total_debt(1:actual_20); % Families in the top 20%
group_80 = total_debt(actual_80_start:actual_80_end); % Families in the bottom 80%

% Output check
fprintf('Number of families in the top 20%%: %d\n', length(group_20));
fprintf('Number of families in the bottom 80%%: %d\n', length(group_80));

%% 

% Assume that 'wealth' is an ascending-ordered vector of wealth 
% and has already been split into the top 20% and bottom 80%.
% Continuing from the previous code:
% group_20: Wealth vector of the top 20% of families
% group_80: Wealth vector of the bottom 80% of families

% Number of groups
num_groups = 400;

% Splitting the top 20% of families
num_20 = length(group_20); 
group_20_size = floor(num_20 / num_groups);  % Number of families per group

% If divisible exactly, group directly; otherwise, handle the remaining families
extra_20 = num_20 - group_20_size * num_groups;  % Extra families
group_20_avg_debt = zeros(num_groups, 1);  % Store the average wealth for each group

% Divide into 400 groups and compute the average wealth for each group
for i = 1:num_groups
    start_idx = (i - 1) * group_20_size + 1;
    end_idx = i * group_20_size;
    
    % Handle remaining families at the end
    if i <= extra_20
        end_idx = end_idx + 1;
    end
    
    % Compute the average wealth for each group
    group_20_avg_debt(i) = mean(group_20(start_idx:end_idx));
end

% Splitting the bottom 80% of families
num_80 = length(group_80);
group_80_size = floor(num_80 / num_groups);  % Number of families per group

% If divisible exactly, group directly; otherwise, handle the remaining families
extra_80 = num_80 - group_80_size * num_groups;  % Extra families
group_80_avg_debt = zeros(num_groups, 1);  % Store the average wealth for each group

% Divide into 400 groups and compute the average wealth for each group
for i = 1:num_groups
    start_idx = (i - 1) * group_80_size + 1;
    end_idx = i * group_80_size;
    
    % Handle remaining families at the end
    if i <= extra_80
        end_idx = end_idx + 1;
    end
    
    % Compute the average wealth for each group
    group_80_avg_debt(i) = mean(group_80(start_idx:end_idx));
end

% Output check
fprintf('Size of the average wealth vector for the top 20%% groups: %d x 1\n', length(group_20_avg_debt));
fprintf('Size of the average wealth vector for the bottom 80%% groups: %d x 1\n', length(group_80_avg_debt));

%% 

% Assume that the variables income, consumption, and assets correspond to 
% income, consumption, and assets, respectively.
epsilon = 1e-6; % Avoid zero values when applying log transformation
D1_real = log(group_20_avg_debt + 1 + epsilon);
D2_real = log(group_80_avg_debt + 1 + epsilon);
