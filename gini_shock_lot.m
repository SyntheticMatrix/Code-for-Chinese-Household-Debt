%
w1_series = W1_liq_matrix + W1_ill_matrix;
w1_series_s = sort(w1_series,1);
w1_series_s = exp(w1_series_s) - 2*epsilon - 2;
w1cum = cumsum(w1_series_s,1) ./ sum(w1_series_s,1);
gini_series = 1 - 2 * sum(lorenz_curve .* w1cum,1) / 400;
gini_resp1 = gini_series(1:10);

w2_series = W2_liq_matrix + W2_ill_matrix;
w2_series_s = sort(w2_series,1);
w2_series_s = exp(w2_series_s) - 2*epsilon -2;
w2cum = cumsum(w2_series_s,1) ./ sum(w2_series_s,1);
gini_series2 = 1 - 2 * sum(lorenz_curve .* w2cum,1) / 400;
gini_resp2 = gini_series2(1:10);

WW_matrix = zeros(800,100);
WW_matrix(1:400,:) = w1_series_s;
WW_matrix(401:800,:) = w2_series_s;

ww_series_s = sort(WW_matrix,1);
wwcum = cumsum(ww_series_s,1) ./ sum(ww_series_s,1);
gini_agg = 1 - 2 * sum(lorenz_curveA .* wwcum,1) / 800;
gini_resp_agg = gini_agg(1:10);

% 
time = 1:10;

% gini dynamics
figure;
plot(time, gini_resp_agg, 'LineWidth', 2, 'Color', [0, 0.4470, 0.7410]); % 蓝色
hold on;
plot(time, gini_resp1, '--', 'LineWidth', 2, 'Color', [0.8500, 0.3250, 0.0980]); % 红色虚线
plot(time, gini_resp2, '-.', 'LineWidth', 2, 'Color', [0.9290, 0.6940, 0.1250]); % 黄色点划线
hold off;

% 
legend('Aggregated Gini', 'Heterogeneity Type 1', 'Heterogeneity Type 2', 'Location', 'Northeast');
xlabel('Periods');
ylabel('Gini Index');
title('Impulse Response of Gini Index');
grid on;

% 
set(gca, 'FontSize', 12);
set(gca, 'FontName', 'Times');
