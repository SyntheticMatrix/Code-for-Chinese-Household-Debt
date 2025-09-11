% ==============================================================================
% Plot figures
% ==============================================================================

% ------------------------------------------------------------------------------
% Consumption policies
 
figure()
set(gcf,'Units','centimeters','Position',[20 10 16 9]);

subplot(1,2,1)
surf(grids.b(2:end), grids.a(2:end-1), soldiff.c(2:end,2:end-1,1)','EdgeAlpha',0.1) % 排除第一个b元素
set(gca,'FontSize',9)
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax]) % 保持原x轴范围
ylim([par.amin par.amax])
title('C, LI, LF, LNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

subplot(1,2,2)
surf(grids.b(2:end), grids.a(2:end-1), soldiff.c(2:end,2:end-1,2)','EdgeAlpha',0.1) % 排除第一个b元素
set(gca,'FontSize',9)
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax])
ylim([par.amin par.amax])
title('C, LI, LF, HNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

exportgraphics(gcf,'plot_consumption.pdf','BackgroundColor','none')

% ------------------------------------------------------------------------------
% Deposit policies

figure()
set(gcf,'Units','centimeters','Position',[20 10 16 9]);

subplot(1,2,1)
surf(grids.b(2:end), grids.a(2:end-1), soldiff.d(2:end,2:end-1,1)','EdgeAlpha',0.2) % 调整数据维度
set(gca,'FontSize',9)
view([-70 30])
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax])
ylim([par.amin par.amax])
title('T, LI, LF, LNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

subplot(1,2,2)
surf(grids.b(2:end), grids.a(2:end-1), soldiff.d(2:end,2:end-1,2)','EdgeAlpha',0.2) % 调整数据维度
set(gca,'FontSize',9)
view([-70 30])
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax])
ylim([par.amin par.amax])
title('T, LI, LF, HNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

exportgraphics(gcf,'plot_deposit.pdf','BackgroundColor','none')

% ------------------------------------------------------------------------------
% Liquid saving policies

figure()
set(gcf,'Units','centimeters','Position',[20 10 16 9]);

subplot(1,2,1)
surf(grids.b(2:end), grids.a(2:end-1), soldiff.sb(2:end,2:end-1,1)','EdgeAlpha',0.2) % 调整维度
view([-40 20])
set(gca,'FontSize',9)
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax])
ylim([par.amin par.amax])
title('FD, LI, LF, LNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex', 'TickLabelInterpreter', 'latex');

subplot(1,2,2)
surf(grids.b(2:end), grids.a(2:end-1), soldiff.sb(2:end,2:end-1,2)','EdgeAlpha',0.2) % 调整维度
view([-40 20])
set(gca,'FontSize',9)
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax])
ylim([par.amin par.amax])
title('FD, LI, LF, HNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

exportgraphics(gcf,'plot_liquidSaving.pdf','BackgroundColor','none')

% ------------------------------------------------------------------------------
% Illiquid saving policies

figure()
set(gcf,'Units','centimeters','Position',[20 10 16 9]);

subplot(1,2,1)
surf(grids.b(2:end), grids.a(2:end-1), soldiff.sa(2:end,2:end-1,1)','EdgeAlpha',0.2) % 调整维度
set(gca,'FontSize',9)
view([-40 20])
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
title('NFD, LI, LF, LNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

subplot(1,2,2)
surf(grids.b(2:end), grids.a(2:end-1), soldiff.sa(2:end,2:end-1,2)','EdgeAlpha',0.2) % 调整维度
set(gca,'FontSize',9)
view([-40 20])
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax])
ylim([par.amin par.amax])
title('NFD, LI, LF, HNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

exportgraphics(gcf,'plot_illiqduisSaving.pdf','BackgroundColor','none')

% ------------------------------------------------------------------------------
% Distributions

figure()
set(gcf,'Units','centimeters','Position',[20 10 16 9]);

subplot(1,2,1)
surf(grids.b(2:end), grids.a(2:end-1), soldiff.g(2:end,2:end-1,1)','EdgeAlpha',0.1) % 调整维度
set(gca,'FontSize',9)
view([-70 30])
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax])
ylim([par.amin par.amax])
zlim([0,inf])
title('SD, LI, LF, LNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

subplot(1,2,2)
surf(grids.b(2:end), grids.a(2:end-1), soldiff.g(2:end,2:end-1,2)', 'EdgeAlpha',0.1) % 调整维度
set(gca,'FontSize',9)
view([-70 30])
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax])
ylim([par.amin par.amax])
zlim([0,inf])
title('SD, LI, LF, HNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

exportgraphics(gcf,'plot_distribution.pdf','BackgroundColor','none')

% ------------------------------------------------------------------------------
% Phase diagrams overlaid with density contour

figure()
set(gcf,'Units','centimeters','Position',[20 10 16 9]);

gsig = soldiff.g .* (soldiff.g>1e-10);
sc   = 3; % Determines density of arrows on plot

subplot(1,2,1)
quiver(grids.bbb(2:sc:end,1:sc:end,1), grids.aaa(2:sc:end,1:sc:end,1),... % 调整起始索引
        soldiff.sb(2:sc:end,1:sc:end,1), soldiff.sa(2:sc:end,1:sc:end,1),0)       % 调整数据索引
hold on
contour(grids.b(2:end), grids.a, gsig(2:end,:,1)') % 调整维度
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax])
ylim([par.amin par.amax])
title('PD, LI, LF, LNF','Interpreter','latex')
hold off
set(gca, 'TickLabelInterpreter', 'latex');

subplot(1,2,2)
quiver(grids.bbb(2:sc:end,1:sc:end,2), grids.aaa(2:sc:end,1:sc:end,2),... % 调整起始索引
        soldiff.sb(2:sc:end,1:sc:end,2), soldiff.sa(2:sc:end,1:sc:end,2),0)       % 调整数据索引
hold on
contour(grids.b(2:end), grids.a, gsig(2:end,:,2)') % 调整维度
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax])
ylim([par.amin par.amax])
title('PD, LI, LF, LNF','Interpreter','latex')
hold off
set(gca, 'TickLabelInterpreter', 'latex');

exportgraphics(gcf,'plot_phaseDiagrams.pdf','BackgroundColor','none')