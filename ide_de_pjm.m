IR_all_x = IRPJ_H(:,1);
IR_all_pi = IRPJ_H(:,2);
IR_all_ct_x = IRPJDT_H(:,1);
IR_all_ct_pi = IRPJDT_H(:,2);
%% 

IR_ide_x = IRPJ_HIE(:,1);
IR_ide_pi = IRPJ_HIE(:,2);
IR_de_x = IR_all_x - IR_ide_x;
IR_de_pi = IR_all_pi - IR_ide_pi;
IR_ide_ct_x = IRPJDT_HIE(:,1);
IR_ide_ct_pi = IRPJDT_HIE(:,2);
IR_de_ct_x = IR_all_ct_x - IR_ide_ct_x;
IR_de_ct_pi = IR_all_ct_pi - IR_ide_ct_pi;


%% 


x = 1:40;
x = x';

% Data for Output gap
z_gap=IR_all_x(1:40)';
ae_gap = IR_ide_x(1:40)';
aa_gap = IR_de_x(1:40)';
aaa_gap = IR_all_ct_x(1:40)';
aaaa_gap = IR_ide_ct_x(1:40)';
aaaaa_gap = IR_de_ct_x(1:40)';

% Data for Traditional sectoral Price level
z_inflation_m=IR_all_pi(1:40)';
ae_inflation_m =IR_ide_pi(1:40)';
aa_inflation_m = IR_de_pi(1:40)';
aaa_if = IR_all_ct_pi(1:40)';
aaaa_if = IR_ide_ct_pi(1:40)';
aaaaa_if = IR_de_ct_pi(1:40)';
%% 

figure;
subplot(1,2,1);
plot(x, z_gap, '-o', 'Color', [0 0.447 0.741], 'MarkerSize', 4, 'LineWidth', 1.5); % 深蓝色
hold on;
plot(x, ae_gap, '--x', 'Color', [0.850 0.325 0.098], 'MarkerSize', 4, 'LineWidth', 1.5); % 红色虚线
hold on;
plot(x, aa_gap, '-s', 'Color', [0.929 0.694 0.125], 'MarkerSize', 4, 'LineWidth', 1.5); % 黄色方块
hold on;
plot(x, aaa_gap, '-^', 'Color', [0.4940 0.1840 0.5560], 'MarkerSize', 4, 'LineWidth', 1.5); % 紫色
hold on;
plot(x, aaaa_gap, '-d', 'Color', [0.4660 0.6740 0.1880], 'MarkerSize', 4, 'LineWidth', 1.5); % 绿色
hold on;
plot(x, aaaaa_gap, '-v', 'Color', [0.6350 0.0780 0.1840], 'MarkerSize', 4, 'LineWidth', 1.5); % 深红
hold off;
title('\bf Output Gap', 'FontSize', 12);
xlabel('Periods', 'FontSize', 10);
ylabel('Responses', 'FontSize', 10);
grid on;
%legend({'z\_gap', 'ae\_gap', 'third\_series'}, 'Location', 'Best', 'FontSize', 9);



subplot(1,2,2);
plot(x, z_inflation_m, '-o', 'Color', [0 0.447 0.741], 'MarkerSize', 4, 'LineWidth', 1.5); % 深蓝色
hold on;
plot(x, ae_inflation_m, '--x', 'Color', [0.850 0.325 0.098], 'MarkerSize', 4, 'LineWidth', 1.5); % 红色虚线
hold on;
plot(x, aa_inflation_m, '-s', 'Color', [0.929 0.694 0.125], 'MarkerSize', 4, 'LineWidth', 1.5); % 黄色方块
hold on;
plot(x, aaa_if, '-^', 'Color', [0.4940 0.1840 0.5560], 'MarkerSize', 4, 'LineWidth', 1.5); % 紫色
hold on;
plot(x, aaaa_if, '-d', 'Color', [0.4660 0.6740 0.1880], 'MarkerSize', 4, 'LineWidth', 1.5); % 绿色
hold on;
plot(x, aaaaa_if, '-v', 'Color', [0.6350 0.0780 0.1840], 'MarkerSize', 4, 'LineWidth', 1.5); % 深红
hold off;
title('\bf Price Level', 'FontSize', 12);
xlabel('Periods', 'FontSize', 10);
ylabel('Responses', 'FontSize', 10);
grid on;


 




