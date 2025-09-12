
%% 

% DAR
testtt = (1/0.0936)*(sol.dbt - sol.sd)./(grids.aaa+grids.bbb);
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

%% Calculation of the DAR among the four sub-groups
% Weight (optional)
grids.wealth = grids.aaa +grids.bbb;
data = grids.wealth;
ratio =  (1/0.0936)*(sol.dbt - sol.sd)./(grids.aaa+grids.bbb);
% 
q = quantile(data, [0.25 0.5 0.75]);


group = zeros(size(data)); 
group(data <= q(1)) = 1;                         
group(data > q(1) & data <= q(2)) = 2;           
group(data > q(2) & data <= q(3)) = 3;           
group(data > q(3)) = 4;                          


[~, idx] = sort(group);
sorted_data = data(idx);
sorted_group = group(idx);


disp(table(sorted_data, sorted_group))

%% 


grids.wealth = grids.aaa+grids.bbb;
data = grids.wealth;



aaa_raw = (grids.aaa);
bbb_raw = (grids.bbb);


wealth_star = aaa_raw + bbb_raw; 


q = quantile(wealth_star, [0.25 0.5 0.75]);
group = zeros(size(wealth_star));
group(wealth_star <= q(1)) = 1;
group(wealth_star > q(1) & wealth_star <= q(2)) = 2;
group(wealth_star > q(2) & wealth_star <= q(3)) = 3;
group(wealth_star > q(3)) = 4;

mean_ratio = zeros(4,1);
for g = 1:4
    mean_ratio(g) = mean(ratio(group == g));
end

disp(mean_ratio)

%% 

% PC
 
figure()
set(gcf,'Units','centimeters','Position',[20 10 16 9]);

subplot(1,2,1)
surf(grids.b(2:end-1), grids.a(2:end-1), ratio(2:end-1,2:end-1,1)','EdgeAlpha',0.1) 
set(gca,'FontSize',9)
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax]) 
ylim([par.amin par.amax])
title('PC, LI, LF, LNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

subplot(1,2,2)
surf(grids.b(2:end-1), grids.a(2:end-1), ratio(2:end-1,2:end-1,2)','EdgeAlpha',0.1) 
set(gca,'FontSize',9)
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax])
ylim([par.amin par.amax])
title('PC, LI, LF, HNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

exportgraphics(gcf,'plot_consumption.pdf','BackgroundColor','none')

%% 

 
figure()
set(gcf,'Units','centimeters','Position',[20 10 16 9]);

subplot(1,2,1)
surf(grids.b(2:end-1), grids.a(2:end-1), ratio(2:end-1,2:end-1,7)','EdgeAlpha',0.1) 
set(gca,'FontSize',9)
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax]) 
ylim([par.amin par.amax])
title('PC, HI, HF, LNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

subplot(1,2,2)
surf(grids.b(2:end-1), grids.a(2:end-1), ratio(2:end-1,2:end-1,8)','EdgeAlpha',0.1)
set(gca,'FontSize',9)
xlabel('Fina','Interpreter','latex')
ylabel('Non-Fina','Interpreter','latex')
xlim([par.bmin par.bmax])
ylim([par.amin par.amax])
title('PC, HI, HF, HNF','Interpreter','latex')
set(gca, 'TickLabelInterpreter', 'latex');

exportgraphics(gcf,'plot_consumption.pdf','BackgroundColor','none')



