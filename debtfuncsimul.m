% Hypothetical time series and independent variables (user needs to provide real data)
time = linspace(0, 2*pi, 130)'; % Time series, column vector
%Y = rand(size(time));           % Output (user needs to replace with real data)
%Pi = rand(size(time));          % Price level
W_liq = assets;       % Liquid assets
%W_ill = rand(size(time));       % Illiquid assets
C = output_a;           % Consumption

% Target variable: borrowing behavior (B)
B = borrowing; % Add noise

% Check for NaN or invalid values in data
if any(isnan(B)) || any(isinf(B))
    error('Data contains NaN or invalid values. Please check the data!');
end

% Custom fitting function
fit_func = @(params, time) ...
    params(1) * sin(W_liq) + params(2) * cos(W_liq) + params(3) * sin(C) + ...
    params(4) * cos(C)  + params(5);

% Initial parameter guesses
init_params = [0.1, 0.1, 0.1, 0.1, 0.1, 0.1]; % Initial guesses for coefficients of each variable

% Optimize fitting parameters
options = optimset('Display', 'off', 'TolFun', 1e-6, 'MaxIter', 1000);
optimized_params = lsqcurvefit(@(p, t) fit_func(p, t), init_params, time, B, [], [], options);

% Plot fitting results
fitted_B = fit_func(optimized_params, time);
figure;
plot(time, B, 'b');
hold on;
plot(time, fitted_B, 'r', 'LineWidth', 2);
legend('Original data', 'Fitted curve');
title('Borrowing Behavior Fitting');
xlabel('Time');
ylabel('Borrowing Level B');
grid on;

% Display explicit form of fitted function
disp('The explicit fitted function is:');
fprintf('B(t) = %.4f*sin(W) + %.4f*cos(W) + %.4f*sin(C) + %.4f*cos(C) + %.4f\n', ...
    optimized_params);

% Display fitted parameter values
disp('Fitted parameter values are:');
disp(optimized_params);