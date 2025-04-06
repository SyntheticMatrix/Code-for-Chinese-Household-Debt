function C1_interp_coeff = precompute_chebyshev(C1, n_points, K)
    % Calculate Chebyshev interpolation coefficients
    % C1: Initial consumption path
    % num_individuals: Number of individuals (e.g., 400)
    % degree: Interpolation degree, typically the polynomial degree

    % Parameter settings
n_points = 40;  % Number of nodes, adjustable as needed
a = 1;          % Left endpoint of the interval
b = 10;         % Right endpoint of the interval

% Step 1: Generate standard Chebyshev nodes (on [-1, 1] interval)
chebyshev_nodes_standard = cos((2*(1:n_points) - 1) * pi / (2*n_points));

% Step 2: Map nodes to [1, 10] interval
% Linear transformation formula: mapped_node = a + (b-a)*(node+1)/2
chebyshev_nodes = a + (b - a) * (chebyshev_nodes_standard + 1) / 2;

% Optional nonlinear mapping to emphasize left-tail distribution (e.g., squared mapping)
% chebyshev_nodes = a + (b - a) * ((chebyshev_nodes_standard + 1) / 2).^2;

% Step 3: Visualize node distribution
figure;
plot(chebyshev_nodes, zeros(size(chebyshev_nodes)), 'o', 'MarkerSize', 8, 'LineWidth', 1.5);
xlim([a, b]);
ylim([-0.5, 0.5]);
title('Distribution of Chebyshev Nodes');
xlabel('Consumption Interval [1, 10]');
    disp(['C1 size: ', num2str(size(C1))]);
disp(['C1(1:n_points) size: ', num2str(size(C1(1:n_points)))]);
disp(['chebyshev_nodes size: ', num2str(size(chebyshev_nodes))]);
% Check for NaN or Inf in chebyshev_nodes and C1
if any(isnan(C1(1:n_points))) || any(isnan(chebyshev_nodes))
    error('C1 or chebyshev_nodes contains NaN values.');
end

if any(isinf(C1(1:n_points))) || any(isinf(chebyshev_nodes))
    error('C1 or chebyshev_nodes contains Inf values.');
end
    % Step 2: Interpolate consumption data onto Chebyshev nodes
    % Interpolation degree controls the polynomial order
    % Ensure inputs are column vectors (compatible with polyfit)
chebyshev_nodes = chebyshev_nodes(:);  % Convert to column vector
C1_sub = C1(1:n_points);  % Extract subset
C1_sub = C1_sub(:);  % Convert to column vector

% Print converted sizes for verification
disp(['Converted chebyshev_nodes size: ', num2str(size(chebyshev_nodes))]);
disp(['Converted C1_sub size: ', num2str(size(C1_sub))]);

% Perform Chebyshev interpolation calculation
C1_interp_coeff = polyfit(chebyshev_nodes, C1_sub, K);  % Use polyfit for interpolation
    % Return Chebyshev interpolation coefficients
end