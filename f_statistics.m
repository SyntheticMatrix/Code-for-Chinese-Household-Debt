% Assume w_agg is a 400x1 vector recording household wealth
% w_agg = ...; % Your wealth data
w_agg = W1_liq_matrix + W1_ill_matrix;
%w_agg = w_agg(:,15);
w_agg = w_agg(:,17);
w_agg = exp(w_agg+2);
% Sort the wealth vector
sorted_w_agg = sort(w_agg);

% Calculate total wealth
total_wealth = sum(sorted_w_agg);

% Calculate the wealth share of the top 10%
top_10_percent = sorted_w_agg(end - round(0.10 * length(sorted_w_agg)) + 1:end);
top_10_percent_wealth = sum(top_10_percent);
top_10_percent_ratio = top_10_percent_wealth / total_wealth;

% Calculate the wealth share of the top 1%
top_1_percent = sorted_w_agg(end - round(0.01 * length(sorted_w_agg)) + 1:end);
top_1_percent_wealth = sum(top_1_percent);
top_1_percent_ratio = top_1_percent_wealth / total_wealth;

% Calculate the wealth share of the bottom 50%
bottom_50_percent = sorted_w_agg(1:round(0.50 * length(sorted_w_agg)));
bottom_50_percent_wealth = sum(bottom_50_percent);
bottom_50_percent_ratio = bottom_50_percent_wealth / total_wealth;

% Calculate the wealth share of the bottom 25%
bottom_25_percent = sorted_w_agg(1:round(0.25 * length(sorted_w_agg)));
bottom_25_percent_wealth = sum(bottom_25_percent);
bottom_25_percent_ratio = bottom_25_percent_wealth / total_wealth;

% Output results
fprintf('Top 10%% wealth share: %.2f%%\n', top_10_percent_ratio * 100);
fprintf('Top 1%% wealth share: %.2f%%\n', top_1_percent_ratio * 100);
fprintf('Bottom 50%% wealth share: %.2f%%\n', bottom_50_percent_ratio * 100);
fprintf('Bottom 25%% wealth share: %.2f%%\n', bottom_25_percent_ratio * 100);

%% 
% Assume w_agg is a 400x1 vector recording household wealth
% w_agg = ...; % Your wealth data
w_agg = W1_liq_matrix + W1_ill_matrix;
%w_agg = w_agg(:,8);
w_agg = w_agg(:,12);
w_agg = exp(w_agg+2);
% Sort the wealth vector
sorted_w_agg = sort(w_agg);

% Calculate total wealth
total_wealth = sum(sorted_w_agg);

% Calculate the wealth share of the top 10%
top_10_percent = sorted_w_agg(end - round(0.10 * length(sorted_w_agg)) + 1:end);
top_10_percent_wealth = sum(top_10_percent);
top_10_percent_ratio = top_10_percent_wealth / total_wealth;

% Calculate the wealth share of the top 1%
top_1_percent = sorted_w_agg(end - round(0.01 * length(sorted_w_agg)) + 1:end);
top_1_percent_wealth = sum(top_1_percent);
top_1_percent_ratio = top_1_percent_wealth / total_wealth;

% Calculate the wealth share of the bottom 50%
bottom_50_percent = sorted_w_agg(1:round(0.50 * length(sorted_w_agg)));
bottom_50_percent_wealth = sum(bottom_50_percent);
bottom_50_percent_ratio = bottom_50_percent_wealth / total_wealth;

% Calculate the wealth share of the bottom 25%
bottom_25_percent = sorted_w_agg(1:round(0.25 * length(sorted_w_agg)));
bottom_25_percent_wealth = sum(bottom_25_percent);
bottom_25_percent_ratio = bottom_25_percent_wealth / total_wealth;

% Output results
fprintf('Top 10%% wealth share: %.2f%%\n', top_10_percent_ratio * 100);
fprintf('Top 1%% wealth share: %.2f%%\n', top_1_percent_ratio * 100);
fprintf('Bottom 50%% wealth share: %.2f%%\n', bottom_50_percent_ratio * 100);
fprintf('Bottom 25%% wealth share: %.2f%%\n', bottom_25_percent_ratio * 100);

%% 
% Assume w_agg is a 400x1 vector recording household wealth
% w_agg = ...; % Your wealth data
w_agg = w1_liq_real+w1_ill_real;
w_agg = exp(w_agg+2);
% Sort the wealth vector
sorted_w_agg = sort(w_agg);

% Calculate total wealth
total_wealth = sum(sorted_w_agg);

% Calculate the wealth share of the top 10%
top_10_percent = sorted_w_agg(end - round(0.10 * length(sorted_w_agg)) + 1:end);
top_10_percent_wealth = sum(top_10_percent);
top_10_percent_ratio = top_10_percent_wealth / total_wealth;

% Calculate the wealth share of the top 1%
top_1_percent = sorted_w_agg(end - round(0.01 * length(sorted_w_agg)) + 1:end);
top_1_percent_wealth = sum(top_1_percent);
top_1_percent_ratio = top_1_percent_wealth / total_wealth;

% Calculate the wealth share of the bottom 50%
bottom_50_percent = sorted_w_agg(1:round(0.50 * length(sorted_w_agg)));
bottom_50_percent_wealth = sum(bottom_50_percent);
bottom_50_percent_ratio = bottom_50_percent_wealth / total_wealth;

% Calculate the wealth share of the bottom 25%
bottom_25_percent = sorted_w_agg(1:round(0.25 * length(sorted_w_agg)));
bottom_25_percent_wealth = sum(bottom_25_percent);
bottom_25_percent_ratio = bottom_25_percent_wealth / total_wealth;

% Output results
fprintf('Top 10%% wealth share: %.2f%%\n', top_10_percent_ratio * 100);
fprintf('Top 1%% wealth share: %.2f%%\n', top_1_percent_ratio * 100);
fprintf('Bottom 50%% wealth share: %.2f%%\n', bottom_50_percent_ratio * 100);
fprintf('Bottom 25%% wealth share: %.2f%%\n', bottom_25_percent_ratio * 100);