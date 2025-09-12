
n = size(A1,1);
M = 2; % total regimes 


nk = 5;
nj = n - nk;

% deconstruct and reconstruct the matrix to place the state and control
% variables rightly
A1_ss = A1(1:nk, 1:nk);
A1_su = A1(1:nk, nk+1:end);
A1_us = A1(nk+1:end, 1:nk);
A1_uu = A1(nk+1:end, nk+1:end);

B1_ss = B1(1:nk, 1:nk);
B1_su = B1(1:nk, nk+1:end);
B1_us = B1(nk+1:end, 1:nk);
B1_uu = B1(nk+1:end, nk+1:end);

A2_ss = A2(1:nk, 1:nk);
A2_su = A2(1:nk, nk+1:end);
A2_us = A2(nk+1:end, 1:nk);
A2_uu = A2(nk+1:end, nk+1:end);

B2_ss = B2(1:nk, 1:nk);
B2_su = B2(1:nk, nk+1:end);
B2_us = B2(nk+1:end, 1:nk);
B2_uu = B2(nk+1:end, nk+1:end);

% Initialize the expanded matrix
N = (nk + nj) * M;
A_MS = zeros(N, N);
B_MS = zeros(N, N);

% Helper function
row_idx = @(regime) ((regime-1)*(nk+nj) + 1) : (regime*(nk+nj));
col_idx = row_idx;

% index
row_ss = @(regime) ((regime-1)*nk + 1) : (regime*nk);
row_su = @(regime) (M*nk + (regime-1)*nj + 1) : (M*nk + regime*nj);

col_ss = @(regime) ((regime-1)*nk + 1) : (regime*nk);
col_su = @(regime) (M*nk + (regime-1)*nj + 1) : (M*nk + regime*nj);

% construct the joint matrix
for i = 1:M
    for j = 1:M
        Pi_ij = Pi(i,j);

        
        % states
        A_MS(row_ss(i), col_ss(j)) = Pi_ij * (i == j) * (i==1)*A1_ss + Pi_ij * (i == j) * (i==2)*A2_ss;
        if i==j
            if i==1
                A_MS(row_ss(i), col_ss(j)) = Pi_ij * A1_ss;
                A_MS(row_ss(i), col_su(j)) = Pi_ij * A1_su;
                A_MS(row_su(i), col_ss(j)) = Pi_ij * A1_us;
                A_MS(row_su(i), col_su(j)) = Pi_ij * A1_uu;
            elseif i==2
                A_MS(row_ss(i), col_ss(j)) = Pi_ij * A2_ss;
                A_MS(row_ss(i), col_su(j)) = Pi_ij * A2_su;
                A_MS(row_su(i), col_ss(j)) = Pi_ij * A2_us;
                A_MS(row_su(i), col_su(j)) = Pi_ij * A2_uu;
            end
        else
            
        end

        % B Matrix
        if i==j
            if i==1
                B_MS(row_ss(i), col_ss(j)) = Pi_ij * B1_ss;
                B_MS(row_ss(i), col_su(j)) = Pi_ij * B1_su;
                B_MS(row_su(i), col_ss(j)) = Pi_ij * B1_us;
                B_MS(row_su(i), col_su(j)) = Pi_ij * B1_uu;
            elseif i==2
                B_MS(row_ss(i), col_ss(j)) = Pi_ij * B2_ss;
                B_MS(row_ss(i), col_su(j)) = Pi_ij * B2_su;
                B_MS(row_su(i), col_ss(j)) = Pi_ij * B2_us;
                B_MS(row_su(i), col_su(j)) = Pi_ij * B2_uu;
            end
        else
            
        end
    end
end


nk_MS = nk * M;

% QZ
[f_MS, p_MS] = solab(A_MS, B_MS, nk_MS);

%% 
x2_3 = [-0.100969679661969,-0.0216352685276741,-0.00290447746472889,0,1,-0.100969679661969,-0.0216352685276741,-0.00290447746472889,0,1];
x2_4 = [0.000192570554594023,-0.000643571892162945,0,0.0672940210069774,1,0.000192570554594023,-0.000643571892162945,0,0.0672940210069774,1];
IRRIG=ir(f_MS,p_MS,x2_3,100);
f_MSindirect = f_MS;
f_MSindirect(:,[5,10]);
IRRIG_IE = ir(f_MSindirect, p_MS, x2_4, 100);

IRRIG_H=ir(f_MS,p_MS,x2_3,100);
IRRIG_HIE = ir(f_MSindirect, p_MS, x2_4, 100);
