x = 1:20;
x = x';

% Data for Output gap
z_gap=IRRIG(1:20,1)';
ae_gap = IRRIG(1:20,5)';


% Data for Traditional sectoral Price level
z_inflation_m=IRRIG(1:20,2)';
ae_inflation_m =IRRIG(1:20,6)';


% Data for Cryptocurrency sectoral price level
z_interest_rate=IRRIG(1:20,3)';
ae_interest_rate = IRRIG(1:20,7)';


% Data for Bilateral Relative Price
z_m=IRRIG(1:20,4)';
ae_m = IRRIG(1:20,8)';


% Data for Crypytocurrency real balance
z_c1=IRRIG(1:20,9)';
ae_c1 =IRRIG_H(1:20,14)';


% Data for Interest rate
z_c2=IRRIG(1:20, 10)';
ae_c2 = IRRIG(1:20,15)';


% Data for Traditional money (real balance)
z_cbdc=IRRIG(1:20, 12)';
ae_cbdc =IRRIG(1:20, 17)';


z_d =IRRIG(1:20, 12)';
ae_d =IRRIG(1:20, 17)';


%% 

figure;
subplot(3,3,1);
plot(x, z_gap, '-o', 'Color', [0 0.447 0.741], 'MarkerSize', 4, 'LineWidth', 1.5); % 深蓝色
hold on;
plot(x, ae_gap, '--x', 'Color', [0.850 0.325 0.098], 'MarkerSize', 4, 'LineWidth', 1.5); % 红色虚线
hold off;
title('\bf Output Gap', 'FontSize', 12);
xlabel('Periods', 'FontSize', 10);
ylabel('Responses', 'FontSize', 10);
grid on;
%legend({'z\_gap', 'ae\_gap', 'third\_series'}, 'Location', 'Best', 'FontSize', 9);



subplot(3,3,2);
plot(x, z_inflation_m, '-o', 'Color', [0 0.447 0.741], 'MarkerSize', 4, 'LineWidth', 1.5); % 深蓝色
hold on;
plot(x, ae_inflation_m, '--x', 'Color', [0.850 0.325 0.098], 'MarkerSize', 4, 'LineWidth', 1.5); % 红色虚线
hold off;
title('\bf Price Level', 'FontSize', 12);
xlabel('Periods', 'FontSize', 10);
ylabel('Responses', 'FontSize', 10);
grid on;


subplot(3,3,3);
plot(x, z_interest_rate, '-o', 'Color', [0 0.447 0.741], 'MarkerSize', 4, 'LineWidth', 1.5); % 深蓝色
hold on;
plot(x, ae_interest_rate, '--x', 'Color', [0.850 0.325 0.098], 'MarkerSize', 4, 'LineWidth', 1.5); % 红色虚线
hold off;
title('\bf Interest Rate', 'FontSize', 12);
xlabel('Periods', 'FontSize', 10);
ylabel('Responses', 'FontSize', 10);
grid on;


subplot(3,3,4);
plot(x, z_m, '-o', 'Color', [0 0.447 0.741], 'MarkerSize', 4, 'LineWidth', 1.5); % 深蓝色
hold on;
plot(x, ae_m, '--x', 'Color', [0.850 0.325 0.098], 'MarkerSize', 4, 'LineWidth', 1.5); % 红色虚线
hold off;
title('\bf Non-financial Asset Rate', 'FontSize', 12);
xlabel('Periods', 'FontSize', 10);
ylabel('Responses', 'FontSize', 10);
grid on;


subplot(3,3,5);
plot(x, z_c1, '-o', 'Color', [0 0.447 0.741], 'MarkerSize', 4, 'LineWidth', 1.5); % 深蓝色
hold on;
plot(x, ae_c1, '--x', 'Color', [0.850 0.325 0.098], 'MarkerSize', 4, 'LineWidth', 1.5); % 红色虚线
hold off;
title('\bf Financial Asset', 'FontSize', 12);
xlabel('Periods', 'FontSize', 10);
ylabel('Responses', 'FontSize', 10);
grid on;

subplot(3,3,6);
plot(x, z_c2, '-o', 'Color', [0 0.447 0.741], 'MarkerSize', 4, 'LineWidth', 1.5); % 深蓝色
hold on;
plot(x, ae_c2, '--x', 'Color', [0.850 0.325 0.098], 'MarkerSize', 4, 'LineWidth', 1.5); % 红色虚线
hold off;
title('\bf Non-financial Asset', 'FontSize', 12);
xlabel('Periods', 'FontSize', 10);
ylabel('Responses', 'FontSize', 10);
grid on;


subplot(3,3,7);
plot(x, z_d, '-o', 'Color', [0 0.447 0.741], 'MarkerSize', 4, 'LineWidth', 1.5); % 深蓝色
hold on;
plot(x, ae_d, '--x', 'Color', [0.850 0.325 0.098], 'MarkerSize', 4, 'LineWidth', 1.5); % 红色虚线
hold off;
title('\bf Debt', 'FontSize', 12);
xlabel('Periods', 'FontSize', 10);
ylabel('Responses', 'FontSize', 10);
grid on;
