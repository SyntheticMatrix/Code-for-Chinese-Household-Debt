%% Sort data

filename = 'time_series.xlsx';
sheet = 'sheet2';

% load
output_a = log(xlsread(filename, sheet, 'F158:F312')); % 
price = xlsread(filename, sheet, 'D158:D312');  % 
interest_rate = xlsread(filename, sheet, 'J158:J312'); % 
assets = xlsread(filename, sheet, 'I158:I311'); % 
housing = xlsread(filename, sheet, 'G158:G311');
borrowing = xlsread(filename, sheet, 'B158:B311'); % 
output_a = diff(output_a);
price = diff(price);
interest_rate = diff(interest_rate);
%% 

%output_a = winsorize(output_a, [0.01, 0.99]);  
window = 24;
rolling_std = movstd(output_a, window);
output_a = output_a(window+1:end) ./ rolling_std(window:end-1);

price = winsorize(price, [0.01, 0.99]);
price = (price - median(price)) / iqr(price);

interest_rate = winsorize(interest_rate, [0.02, 0.98]);
% 
high_vol_period = interest_rate(1:60);
low_vol_period = interest_rate(61:end);
rate_high_adj = (high_vol_period - mean(high_vol_period)) / std(high_vol_period);
rate_low_adj = (low_vol_period - mean(low_vol_period)) / std(low_vol_period);
interest_rate = [rate_high_adj; rate_low_adj];

assets = winsorize(assets, [0.015, 0.985]);
alpha = 0.1;  % 
ewm_std = sqrt(filter(alpha, [1 alpha-1], assets.^2));
assets = assets./ ewm_std;

borrowing = winsorize(borrowing, [0.01, 0.99]);

%% 
assets = assets(13:142);
borrowing = borrowing(13:142);
housing = housing(13:142);
interest_rate =interest_rate(13:142);
price = price(13:142);
%% 

% construct y
y = [output_a, price, interest_rate, assets, housing, borrowing];
%y = diff(y);
%y = diff(y);
% display
disp(' y:');
disp(y);

