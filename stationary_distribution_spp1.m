figure('Color','w','Position',[100 100 1200 450]);

% =====================
% 
% =====================
illiquidWealth = W1_ill_matrix_old(:,12);
liquidWealth = W1_liq_matrix_old(:,12);
new_asset.illiquid = W1_ill_matrix(:,12);
new_asset.liquid = W1_liq_matrix(:,12);
binWidth = 0.1;
binEdges = 0:binWidth:max([illiquidWealth; new_asset.illiquid+new_asset.liquid]);


histogram(illiquidWealth,...
    'BinEdges', binEdges,...
    'Normalization', 'probability',...
    'FaceColor', [0.2 0.2 1],...
    'FaceAlpha', 0.7,...
    'EdgeColor', 'none');
hold on;


histogram(new_asset.illiquid+new_asset.liquid,...
    'BinEdges', binEdges,...
    'Normalization', 'probability',...
    'FaceColor', [1 0.6 0],...
    'FaceAlpha', 0.7,...
    'EdgeColor', 'none');
simulated_mean = mean(illiquidWealth+liquidWealth); 
your_original_illiquid_data = w1_liq_real + w1_ill_real;

original_mean = mean(w1_liq_real+w1_ill_real);


delta_illiquid = mean(illiquidWealth) - mean(your_original_illiquid_data);


[fIlliquidOriginal, xIlliquidOriginal] = ksdensity(your_original_illiquid_data);
xIlliquidShifted = xIlliquidOriginal + delta_illiquid;
plot(xIlliquidShifted, fIlliquidOriginal * binWidth, 'k--', 'LineWidth', 1.5);

yticks = get(gca, 'YTick');
set(gca, 'YTickLabel', yticks * 100);
ylabel('Percent (%)');
xlabel('Wealth');
title('Illiquid Wealth Distribution');
legend({'Time-lag Debt', 'Standard Debt', 'Theoretical'}, 'Location', 'northeast');