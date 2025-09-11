% Consumption policies
 
figure()
set(gcf,'Units','centimeters','Position',[20 10 16 9]);

subplot(1,2,1)
surf(grids.b(2:end-1), grids.a(2:end-1), test(2:end-1,2:end-1,1)','EdgeAlpha',0.1) % 排除第一个b元素
set(gca,'FontSize',9)
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax]) % 保持原x轴范围
ylim([par.amin par.amax])
title('C, LI, LF, LNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

subplot(1,2,2)
surf(grids.b(2:end-1), grids.a(2:end-1), test(2:end-1,2:end-1,2)','EdgeAlpha',0.1) % 排除第一个b元素
set(gca,'FontSize',9)
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax])
ylim([par.amin par.amax])
title('C, LI, LF, HNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

exportgraphics(gcf,'plot_consumption.pdf','BackgroundColor','none')

%% 

% Consumption policies
 
figure()
set(gcf,'Units','centimeters','Position',[20 10 16 9]);

subplot(1,2,1)
surf(grids.b(2:end-1), grids.a(2:end-1), solfinal.dbt(2:end-1,2:end-1,1)','EdgeAlpha',0.1) % 排除第一个b元素
set(gca,'FontSize',9)
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax]) % 保持原x轴范围
ylim([par.amin par.amax])
title('C, LI, LF, LNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

subplot(1,2,2)
surf(grids.b(2:end-1), grids.a(2:end-1), solfinal.dbt(2:end-1,2:end-1,2)','EdgeAlpha',0.1) % 排除第一个b元素
set(gca,'FontSize',9)
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax])
ylim([par.amin par.amax])
title('C, LI, LF, HNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

exportgraphics(gcf,'plot_consumption.pdf','BackgroundColor','none')

%% 

% Consumption policies
testtt = (1/0.0936)*(0.2*sol.dbt - sol.sd)./(grids.aaa+grids.bbb);
figure()
set(gcf,'Units','centimeters','Position',[20 10 16 9]);

subplot(1,2,1)
surf(grids.b(2:end-1), grids.a(2:end-1), testtt(2:end-1,2:end-1,7)','EdgeAlpha',0.1) % 排除第一个b元素
set(gca,'FontSize',9)
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax]) % 保持原x轴范围
ylim([par.amin par.amax])
title('DAR, HI, HF, LNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

subplot(1,2,2)
surf(grids.b(2:end-1), grids.a(2:end-1), testtt(2:end-1,2:end-1,8)','EdgeAlpha',0.1) % 排除第一个b元素
set(gca,'FontSize',9)
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax])
ylim([par.amin par.amax])
title('DAR, HI, HF, HNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

exportgraphics(gcf,'plot_consumption.pdf','BackgroundColor','none')
%% 

% Consumption policies
testttt = (grids.aaa+grids.bbb);
figure()
set(gcf,'Units','centimeters','Position',[20 10 16 9]);

subplot(1,2,1)
surf(grids.b(2:end-1), grids.a(2:end-1), testttt(2:end-1,2:end-1,1)','EdgeAlpha',0.1) % 排除第一个b元素
set(gca,'FontSize',9)
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax]) % 保持原x轴范围
ylim([par.amin par.amax])
title('DAR, LI, LF, LNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

subplot(1,2,2)
surf(grids.b(2:end-1), grids.a(2:end-1), testttt(2:end-1,2:end-1,2)','EdgeAlpha',0.1) % 排除第一个b元素
set(gca,'FontSize',9)
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax])
ylim([par.amin par.amax])
title('C, LI, LF, HNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

exportgraphics(gcf,'plot_consumption.pdf','BackgroundColor','none')

%% 
% 假设 grids.wealth 是一个列向量（N×1）
grids.wealth = grids.aaa +grids.bbb;
data = grids.wealth;
ratio =  (1/0.0936)*(0.2*sol.dbt - sol.sd)./(grids.aaa+grids.bbb);
% 1. 计算四分位数
q = quantile(data, [0.25 0.5 0.75]);

% 2. 根据分位数进行分组
group = zeros(size(data)); % 初始化分组标签
group(data <= q(1)) = 1;                         % 最小的25%
group(data > q(1) & data <= q(2)) = 2;           % 25%-50%
group(data > q(2) & data <= q(3)) = 3;           % 50%-75%
group(data > q(3)) = 4;                          % 最大的25%

% 3. 如果你想要按照分组结果排序，可以用：
[~, idx] = sort(group);
sorted_data = data(idx);
sorted_group = group(idx);

% 输出结果
disp(table(sorted_data, sorted_group))

%% 

% 假设 grids.wealth 和 sol.dbt 是同维度向量
grids.wealth = grids.aaa+grids.bbb;
data = grids.wealth;


% Step 1: 指数还原
aaa_raw = (grids.aaa);
bbb_raw = (grids.bbb);

% Step 2: 定义分组依据（可以直接相加，或者加权相加）
wealth_star = aaa_raw + bbb_raw;   % 用原始数值做分组目标

% Step 3: 分组
q = quantile(wealth_star, [0.25 0.5 0.75]);
group = zeros(size(wealth_star));
group(wealth_star <= q(1)) = 1;
group(wealth_star > q(1) & wealth_star <= q(2)) = 2;
group(wealth_star > q(2) & wealth_star <= q(3)) = 3;
group(wealth_star > q(3)) = 4;

% Step 4: 每组算比例均值（仍然用原始定义的 ratio）
mean_ratio = zeros(4,1);
for g = 1:4
    mean_ratio(g) = mean(ratio(group == g));
end

disp(mean_ratio)

%% 

% Consumption policies
 
figure()
set(gcf,'Units','centimeters','Position',[20 10 16 9]);

subplot(1,2,1)
surf(grids.b(2:end-1), grids.a(2:end-1), ratio(2:end-1,2:end-1,1)','EdgeAlpha',0.1) % 排除第一个b元素
set(gca,'FontSize',9)
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax]) % 保持原x轴范围
ylim([par.amin par.amax])
title('PC, LI, LF, LNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

subplot(1,2,2)
surf(grids.b(2:end-1), grids.a(2:end-1), ratio(2:end-1,2:end-1,2)','EdgeAlpha',0.1) % 排除第一个b元素
set(gca,'FontSize',9)
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax])
ylim([par.amin par.amax])
title('PC, LI, LF, HNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

exportgraphics(gcf,'plot_consumption.pdf','BackgroundColor','none')

%% 

% Consumption policies
 
figure()
set(gcf,'Units','centimeters','Position',[20 10 16 9]);

subplot(1,2,1)
surf(grids.b(2:end-1), grids.a(2:end-1), ratio(2:end-1,2:end-1,7)','EdgeAlpha',0.1) % 排除第一个b元素
set(gca,'FontSize',9)
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax]) % 保持原x轴范围
ylim([par.amin par.amax])
title('PC, HI, HF, LNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

subplot(1,2,2)
surf(grids.b(2:end-1), grids.a(2:end-1), ratio(2:end-1,2:end-1,8)','EdgeAlpha',0.1) % 排除第一个b元素
set(gca,'FontSize',9)
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax])
ylim([par.amin par.amax])
title('PC, HI, HF, HNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

exportgraphics(gcf,'plot_consumption.pdf','BackgroundColor','none')



