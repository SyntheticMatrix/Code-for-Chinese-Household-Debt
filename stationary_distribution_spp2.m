figure('Color','w','Position',[100 100 1200 450]);

% =====================
% 
% =====================
illiquidWealth2 = W2_ill_matrix_old(:,12);
liquidWealth2 = W2_liq_matrix_old(:,12);
new_asset.illiquidt = W2_ill_matrix(:,12);
new_asset.liquid2 = W2_liq_matrix(:,12);
binWidth = 0.1;
binEdges = 0:binWidth:max([illiquidWealth2+liquidWealth2; new_asset.illiquidt+new_asset.liquid2]);

% 
histogram(illiquidWealth2+liquidWealth2,...
    'BinEdges', binEdges,...
    'Normalization', 'probability',...
    'FaceColor', [0.2 0.2 1],...
    'FaceAlpha', 0.7,...
    'EdgeColor', 'none');
hold on;

% 
histogram(new_asset.illiquidt+new_asset.liquid2,...
    'BinEdges', binEdges,...
    'Normalization', 'probability',...
    'FaceColor', [1 0.6 0],...
    'FaceAlpha', 0.7,...
    'EdgeColor', 'none');
simulated_mean = mean(illiquidWealth2+liquidWealth2); 
your_original_illiquid_data = w2_liq_real + w2_ill_real;

original_mean = mean(w2_liq_real+w2_ill_real);


delta_illiquid = mean(illiquidWealth2+liquidWealth2) - mean(your_original_illiquid_data);


[fIlliquidOriginal, xIlliquidOriginal] = ksdensity(your_original_illiquid_data);
xIlliquidShifted = xIlliquidOriginal + delta_illiquid;
plot(xIlliquidShifted, fIlliquidOriginal * binWidth, 'k--', 'LineWidth', 1.5);


yticks = get(gca, 'YTick');
set(gca, 'YTickLabel', yticks * 100);
ylabel('Percent (%)');
xlabel('Wealth');
title('Illiquid Wealth Distribution');
legend({'Time-lag Debt', 'Standard Debt', 'Theoretical'}, 'Location', 'northeast');