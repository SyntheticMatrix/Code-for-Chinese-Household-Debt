%%
b_min = min(W1_liq_matrix(:,15));       
b_max = max(W1_liq_matrix(:,15));       
n_cheb = 3;      
lambda = 1e-5;    

orders = struct('c',3, 'd',3, 'b',3);

%% 
nodes = chebyshevNodes(n_cheb, [b_min, b_max]);

%% 
Phi_c = build_basis_matrix(nodes, orders.c, [b_min, b_max]);
Phi_d = build_basis_matrix(nodes, orders.d, [b_min, b_max]); 
Phi_b = build_basis_matrix(nodes, orders.b, [b_min, b_max]); 

%% 
total_params = (orders.c + 1) + (orders.d + 1) + (orders.b + 1); % 4+4+4=12
Theta_guess = 0.01 * randn(total_params, 1); 

%% 
options = optimoptions('fminunc', 'Algorithm', 'quasi-newton', 'Display', 'iter');
Theta_opt = fminunc(@(Theta) residual_projection(Theta, nodes, ...
                       orders, b_min, b_max, lambda), Theta_guess, options);

%% 
theta_c = Theta_opt(1:orders.c+1);          
theta_d = Theta_opt(orders.c+2:2*(orders.c+1)); 
theta_b = Theta_opt(2*(orders.c+1)+1:end);  

%% 
b_grid = linspace(b_min, b_max, 400)'; 

Phi_c_interp = build_basis_matrix(b_grid, orders.c, [c_min, c_max]);
Phi_d_interp = build_basis_matrix(b_grid, orders.d, [d_min, d_max]);
Phi_b_interp = build_basis_matrix(b_grid, orders.b, [b_min, b_max]);

c_policy = Phi_c_interp * theta_c; % 400x4 * 4x1 → 400x1
d_policy = Phi_d_interp * theta_d;
b_policy = Phi_b_interp * theta_b;


figure;
subplot(3,1,1);
plot(b_grid, c_policy, 'LineWidth', 1.5);
title('Consumption Policy Function');
xlabel('Wealth (b)'); ylabel('c(b)');

subplot(3,1,2);
plot(b_grid, d_policy, 'LineWidth', 1.5);
title('Debt Policy Function');
xlabel('Wealth (b)'); ylabel('d(b)');

subplot(3,1,3);
plot(b_grid, b_policy, 'LineWidth', 1.5);
title('Wealth Transition');
xlabel('Current Wealth (b_t)'); ylabel('Next Wealth (b_{t+1})');



