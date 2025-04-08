%% 
num_periods = 12;   % 
alpha = 0.2;        % 
line_width = 1.5;   % 

%% 
 W1_liq_matrix_old = diff(W1_liq_matrix_old,1,2); %
 W2_liq_matrix_old = diff(W2_liq_matrix_old,1,2); % 
 W1_liq_matrix_new = diff(W1_liq_matrix_new,1,2); % 
 W2_liq_matrix_new = diff(W2_liq_matrix_new,1,2); % 

%% 
% 
[mean_W1, q25_W1, q75_W1] = calc_stats(W1_liq_matrix_old(:,1:num_periods));
[mean_W1n, q25_W1n, q75_W1n] = calc_stats(W1_liq_matrix_new(:,1:num_periods));

% 
[mean_W2, q25_W2, q75_W2] = calc_stats(W2_liq_matrix_old(:,1:num_periods));
[mean_W2n, q25_W2n, q75_W2n] = calc_stats(W2_liq_matrix_new(:,1:num_periods));

%%
figure('Position', [100 100 1200 500])

subplot(1,2,1)
hold on
plot_band(1:num_periods, mean_W1, q25_W1, q75_W1, 'b', 'Time-lag', alpha)
plot_band(1:num_periods, mean_W1n, q25_W1n, q75_W1n, 'r', 'Standard', alpha)
title('Low Type')
xlabel('period'), ylabel('Financial Asset Drift')
grid on

subplot(1,2,2)
hold on
plot_band(1:num_periods, mean_W2, q25_W2, q75_W2, 'b', 'Time-lag', alpha)
plot_band(1:num_periods, mean_W2n, q25_W2n, q75_W2n, 'r', 'Standard', alpha)
title('High Type')
xlabel('Period'), ylabel('Financial Asset Drift')
legend('show', 'Location','best')
grid on


function [m, q1, q3] = calc_stats(data)
    m = mean(data, 1);
    q1 = quantile(data, 0.25, 1);
    q3 = quantile(data, 0.75, 1);
end

function plot_band(x, y, lower, upper, color, leg, alpha)
    fill([x fliplr(x)], [lower fliplr(upper)], color,...
        'FaceAlpha', alpha, 'EdgeColor','none')
    plot(x, y, 'Color', color, 'LineWidth', 2, 'DisplayName', leg)
end
