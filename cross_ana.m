%%

max_lag = 12; 
[c, lags] = xcorr(output_a, borrowing, max_lag, 'coeff'); 


figure;
stem(lags, c, 'filled');
xlabel('Lag');
ylabel('Cross-Correlation Coefficient');
title('Dynamic Cross-Correlation between Output and Debt');


%% 
max_lag = 12; 
[r, lags] = xcorr(output_a, assets, max_lag, 'coeff'); 

figure;
stem(lags, r, 'filled');
xlabel('Lag');
ylabel('Cross-Correlation Coefficient');
title('Dynamic Cross-Correlation between Output and Financial Asset');

