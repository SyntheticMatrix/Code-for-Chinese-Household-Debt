wealth_list = [];
prob_list = [];
% Traverse all grid points and types
for i = 1:40
    for j = 1:40
        for k = 1:2
            % Calculate wealth value W = a + b
            W = grids.aaa(i) + grids.bbb(j);
            W = exp(W);
            % Get stationary distribution probability
            prob = sol.g(i, j, k);
            % Add to lists
            wealth_list = [wealth_list; W];
            prob_list = [prob_list; prob];
        end
    end
end

% Combine wealth values and probabilities into a matrix
wealth_prob_matrix = [wealth_list, prob_list];

% Sort by wealth value in descending order
sorted_matrix = sortrows(wealth_prob_matrix, -1);

% Calculate total wealth
total_wealth = sum(sorted_matrix(:, 1) .* sorted_matrix(:, 2));

% Calculate cumulative wealth
cumulative_wealth = cumsum(sorted_matrix(:, 1) .* sorted_matrix(:, 2));

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