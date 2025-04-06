n = 400; % grid points
W11 = W1_liq_matrix(:,8); W12 = W1_ill_matrix(:,8); W21 = W2_liq_matrix(:,8); W22 = W2_ill_matrix(:,8);
w1_ev = exp(W11) + exp(W12) - epsilon -epsilon - 2;
w2_ev = exp(W21) + exp(W22) - epsilon -epsilon - 2;
sorted_wealth1 = sort(w1_ev); % sorting
sorted_wealth2 = sort(w2_ev); % sorting

% (1) Create the matrix
sorted_wealth_agg = sort([sorted_wealth1; sorted_wealth2]); 

% (2) CDF
cum_wealth1 = cumsum(sorted_wealth1) / sum(sorted_wealth1);
cum_wealth2 = cumsum(sorted_wealth2) / sum(sorted_wealth2);
cum_wealth_agg = cumsum(sorted_wealth_agg) / sum(sorted_wealth_agg);

% share
population_percentile_400 = (1:n)' / n * 100; 
population_percentile_800 = (1:(2*n))' / (2*n) * 100; 

% lorenz curve
figure;
plot(population_percentile_800, cum_wealth_agg, 'LineWidth', 2, 'Color', [0, 0.4470, 0.7410]); % blue
hold on;
plot(population_percentile_400, cum_wealth1, '--', 'LineWidth', 2, 'Color', [0.8500, 0.3250, 0.0980]); % red
plot(population_percentile_400, cum_wealth2, '-.', 'LineWidth', 2, 'Color', [0.9290, 0.6940, 0.1250]); % yellow
plot([0, 100], [0, 1], 'k', 'LineWidth', 1); % 45 degree line
hold off;

% 
xlim([0 100]);
ylim([0 1]);
legend('Aggregated Wealth', 'Heterogeneity Type 1', 'Heterogeneity Type 2', '45 Degree Line', 'Location', 'Southeast');
xlabel('Population percentile');
ylabel('Cumulative Wealth');
title('Lorenz Curve');
grid on;

% 
set(gca, 'FontSize', 12);
set(gca, 'FontName', 'Times');
%% 
lorenz_curve = (1:400)' / 400;
gini_index1 = 1 - 2 * sum(lorenz_curve .* cum_wealth1) / 400;
gini_index2 = 1 - 2 * sum(lorenz_curve .* cum_wealth2) / 400;
lorenz_curveA = (1:800)' / 800;
gini_indexa = 1 - 2 * sum(lorenz_curveA .* cum_wealth_agg) / 800;
