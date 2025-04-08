% Initialize wealth list
wealth_list = [];

% Iterate through all grid points and types
for i = 1:40
    for j = 1:40
        for k = 1:2
            % Calculate wealth value in log scale w = a + b
            w = a_grid(i) + b_grid(j);
            % Convert back to original scale W = exp(w)
            W = exp(w);
            % Add to list
            wealth_list = [wealth_list; W];
        end
    end
end

% Concatenate two 3200x1 lists into a 6400x1 list
extended_wealth_list = [wealth_list; wealth_list];

% Sort wealth values in descending order
sorted_wealth_list = sort(extended_wealth_list, 'descend');

% Calculate total wealth
total_wealth = sum(sorted_wealth_list);

% Calculate cumulative wealth
cumulative_wealth = cumsum(sorted_wealth_list);

% Calculate wealth share of top 10%
target_percentile = 0.10;
idx_10 = find(cumulative_wealth >= target_percentile * total_wealth, 1);
wealth_top10 = cumulative_wealth(idx_10) / total_wealth;

% Calculate wealth share of top 1%
target_percentile = 0.01;
idx_1 = find(cumulative_wealth >= target_percentile * total_wealth, 1);
wealth_top1 = cumulative_wealth(idx_1) / total_wealth;

% Calculate wealth share of bottom 50%
target_percentile = 0.50;
idx_50 = find(cumulative_wealth >= (1 - target_percentile) * total_wealth, 1);
wealth_bottom50 = (total_wealth - cumulative_wealth(idx_50)) / total_wealth;

% Calculate wealth share of bottom 25%
target_percentile = 0.25;
idx_25 = find(cumulative_wealth >= (1 - target_percentile) * total_wealth, 1);
wealth_bottom25 = (total_wealth - cumulative_wealth(idx_25)) / total_wealth;

% Output results
fprintf('Top 10%% wealth share: %.2f%%\n', wealth_top10 * 100);
fprintf('Top 1%% wealth share: %.2f%%\n', wealth_top1 * 100);
fprintf('Bottom 50%% wealth share: %.2f%%\n', wealth_bottom50 * 100);
fprintf('Bottom 25%% wealth share: %.2f%%\n', wealth_bottom25 * 100);