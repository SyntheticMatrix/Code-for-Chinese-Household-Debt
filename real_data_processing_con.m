%%  


total_families = length(total_consump);
% Calculate the target number for the top 20% and bottom 80%
target_20 = round(0.2 * total_families);
target_80 = total_families - target_20;
% If not divisible, we need to balance the adjustment
extra = total_families - (target_20 + target_80);
front_adjust = floor(extra / 2);  % Number removed from the front
back_adjust = extra - front_adjust;  % Number removed from the back

% Update actual indices for the top 20% and bottom 80%
actual_20 = target_20 + front_adjust;
actual_80_start = actual_20 + 1;
actual_80_end = total_families - back_adjust;
% Grouping
group_20 = total_consump(1:actual_20); % Households in the top 20%
group_80 = total_consump(actual_80_start:actual_80_end); % Households in the bottom 80%

% Output check
fprintf('Number of households in the top 20%%: %d\n', length(group_20));
fprintf('Number of households in the bottom 80%%: %d\n', length(group_80));

%% 

% Assume wealth is already sorted in ascending order and has been divided into the top 20% and bottom 80%
% If continuing from the previous code:
% group_20: Wealth vector of the top 20% households
% group_80: Wealth vector of the bottom 80% households

% Number of groups
num_groups = 400;

% Grouping the top 20% households
num_20 = length(group_20); 
group_20_size = floor(num_20 / num_groups);  % Number of households per group

% If divisible, group directly; otherwise, handle the remaining households
extra_20 = num_20 - group_20_size * num_groups;  % Extra households
group_20_avg_con = zeros(num_groups, 1);  % Store the average wealth per group

% Divide into 400 groups and calculate the average wealth per group
for i = 1:num_groups
    start_idx = (i - 1) * group_20_size + 1;
    end_idx = i * group_20_size;
    
    % Handle the remaining households
    if i <= extra_20
        end_idx = end_idx + 1;
    end
    
    % Calculate the average wealth per group
    group_20_avg_con(i) = mean(group_20(start_idx:end_idx));
end

% Grouping the bottom 80% households
num_80 = length(group_80);
group_80_size = floor(num_80 / num_groups);  % Number of households per group

% If divisible, group directly; otherwise, handle the remaining households
extra_80 = num_80 - group_80_size * num_groups;  % Extra households
group_80_avg_con = zeros(num_groups, 1);  % Store the average wealth per group

% Divide into 400 groups and calculate the average wealth per group
for i = 1:num_groups
    start_idx = (i - 1) * group_80_size + 1;
    end_idx = i * group_80_size;
    
    % Handle the remaining households
    if i <= extra_80
        end_idx = end_idx + 1;
    end
    
    % Calculate the average wealth per group
    group_80_avg_con(i) = mean(group_80(start_idx:end_idx));
end

% Output check
fprintf('Size of the average wealth vector per group for the top 20%%: %d x 1\n', length(group_20_avg_con));
fprintf('Size of the average wealth vector per group for the bottom 80%%: %d x 1\n', length(group_80_avg_con));

%% 

% Assume variables income, consumption, and assets are income, consumption, and assets respectively
epsilon = 1e-6; % Avoid log transformation issues with zero values
C1_real = log(group_20_avg_con + 1 + epsilon);
C2_real = log(group_80_avg_con + 1 + epsilon);

