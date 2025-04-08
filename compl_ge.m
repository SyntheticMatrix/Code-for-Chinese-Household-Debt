% variable sequence：
state_vars = {'b', 'a', 'k', 'e', 'd'};      % 5
jump_vars = {'y', 'pi', 'rb'}; % 3
n_states = length(state_vars);               
n_jumps = length(jump_vars);                 
total_vars = n_states + n_jumps;             
%% 
A = zeros(total_vars, total_vars);
B = zeros(total_vars, total_vars); 

%% 
% 行1: b(t+1) =(1+rb_ss)*b(t) - c(t) - d(t) + b_ss * rb(t)
rb_ss = 0.01;
b_ss = 0.0244;
row = 1;
omega = 0.5;
A(row, 1) = 1;       
B(row, 1) = (1 + rb_ss); 
B(row, 2) = omega;
B(row, 6) = -1;   
B(row, 5) = -1;   
B(row, 8) = b_ss;

%% \dot{a} = ra*a +u*k
ra_ss = 0.015;
u = 0.4;
row = 2;
A(row, 2) = 1;      
B(row, 2) = ra_ss;   
B(row, 3) = (1 - u); 

%% \dot{k} = (1-delta)k +omega*a
row = 3;
delta = 0.9;
A(row, 3) = 1;       
B(row, 3) = (1 - delta); 
B(row, 2) = omega;

%% \dot{d} = y - omega*a - b
row = 4;
A(row, 4) = 1;       
B(row, 4) = 0.0425;       
B(row, 1) = -1;      
B(row, 6) = 1; 
B(row, 2) = -omega;

%% 
rho_e = 0.8;
row = 5;
A(row, 5) = 1;       
B(row, 5) = rho_e;   

%% \dot{y} -omega*\dot{a} = y - omega*a +rb -\dot{pi}

row = 6;

B(row, 6) = 1;   
A(row, 6) = 1;   
B(row, 8) = 1;  
A(row, 7) = 1;  
A(row, 2) = -omega;
B(row, 2) = -omega;

%% 
beta = 0.98;
kappa = 0.0823;
row = 7;
B(row, 7) = 1;  
A(row, 7) = beta; 
B(row, 6) = kappa; 

%% 
phi_pi = 1.5;
phi_y = 0.2;
row = 8;
B(row, 8) = 1;   
B(row, 7) = -phi_pi; 
B(row, 6) = -phi_y;
B(row, 5) = -1;                      





%% 
x2_1 = zeros(1,5);
x2_1(1) = mean((W1_liq_matrix(:,5)-W1_liq_matrix(:,4))./W1_liq_matrix(:,4));
x2_1(2) = mean((W1_ill_matrix(:,5)-W1_ill_matrix(:,4))./W1_ill_matrix(:,4));
x2_1(3) = mean((D_matrix(:,5)-D_matrix(:,4))./D_matrix(:,4));
x2_1(4) = 0;
x2_1(5) = 1;
[f,p] = solab(A,B,5);
IR=ir(f,p,x2_1,100);
periods = 1:100;
figure;

for i = 1:8
    subplot(4, 2, i); 
    plot(periods, IR(:, i)); 
    title(['Variable ', num2str(i)]); 
    xlabel('Period'); 
    ylabel('Response'); 
    grid on; 
end

sgtitle('Impulse Response Functions');



%% 
f_indirect = f;
f_indirect(:,5) = 0;
IR=ir(f_indirect,p,x2_1,100);
%% Compute the initial value based on the inter-temporal HJB problem

x2_2 = [0.0016,0.0388, 0, 0, 1 ];
x2_2(1) = mean((W2_liq_matrix(:,5)-W2_liq_matrix(:,4))./W2_liq_matrix(:,4));
x2_2(2) = mean((W2_ill_matrix(:,5)-W2_ill_matrix(:,4))./W2_ill_matrix(:,4));
x2_2(3) = mean((D2_matrix(:,5)-D_matrix(:,4))./D2_matrix(:,4));
x2_2(4) = 0;
x2_2(5) = 1;
IR=ir(f,p,x2_2,100);

%% 
f_indirect = f;
f_indirect(:,5) = 0;
IR=ir(f_indirect,p,x2_2,100);
