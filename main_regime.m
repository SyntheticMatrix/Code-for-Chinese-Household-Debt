%% === Step 1: joint AB matrix construction ===
% regime 1
phi_pi_1 = 1.3312*(0.1106/(1-0.1106));
phi_y_1  = 0.2499*(0.1106/(1-0.1106));
% for k = p =2, please use these at line 11 and 12
phi_pi_3 = 0.765*(0.1106/(1-0.1106));
phi_y_3 = 0.1428*(0.1106/(1-0.1106));

A1 = A; 
B1 = B;
B1(8,7) = -phi_pi_2; % rewrite the response parameter
B1(8,6) = -phi_y_2;  

% regime 2
phi_pi_2 = 0.3683*(0.0526/(1-0.0526));
phi_y_2  = 0.7333*(0.0526/(1-0.0526));
% Similarly, for k = p = 2, please use these at line 23 and 24
phi_pi_4 = 0.2257*(0.0526/(1-0.0526));
phi_y_4 = 0.5789*(0.0526/(1-0.0526));

A2 = A; 
B2 = B;
B2(8,7) = -phi_pi_4; % 
B2(8,6) = -phi_y_4;  % 

%% === Step 2: Construct Markov-switching system ===
% pro matrix, borrowed directly from Zheng et al. (2012)
P_regime = [0.7512 0.2488; 
            0.1449 0.8551];

% Preparation
n_total = total_vars;

% Kronecker joint matrix

A_big = blkdiag(A1, A2);
B_big = blkdiag(B1, B2);

% Place
A_ms = kron(P_regime, eye(n_total)) * A_big;
B_ms = kron(eye(2), eye(n_total)) * B_big;


n_states_big = n_states * 2; 
