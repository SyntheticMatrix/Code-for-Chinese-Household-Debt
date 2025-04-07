function is_stop = check_consecutive_p(p_values, threshold, required_consecutive)
% Check if p-value sequence contains consecutive values exceeding threshold
% Inputs:
%   p_values - Array of computed p-values
%   threshold - Decision threshold (0.1 in this case)
%   required_consecutive - Required consecutive count (5 in this case)
% Output:
%   is_stop - Whether stopping condition is met

is_stop = false;
if length(p_values) < required_consecutive
    return;
end

% Sliding window detection
current_streak = 0;
for i = 1:length(p_values)
    if p_values(i) > threshold
        current_streak = current_streak + 1;
        if current_streak >= required_consecutive
            is_stop = true;
            return;
        end
    else
        current_streak = 0; % Reset counter
    end
end
end