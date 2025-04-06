%% Read total assets
total_asset = readmatrix('Gini1.xlsx', 'Range', 'T2:T27265');
total_consump = readmatrix('Gini1.xlsx', 'Range', 'P2:P27265');
total_debt = readmatrix('Gini1.xlsx', 'Range', 'U2:U27265');
Liq = readmatrix('Gini1.xlsx', 'Range', 'X2:X27265');
Ill = readmatrix('Gini1.xlsx', 'Range', 'Y2:Y27265');

%% Grid expansion
% Ensure both have the same length
nFamilies = length(Liq);
nGrids = 400; % Number of grid points
gridSize = floor(nFamilies / nGrids); % Number of families in each grid
gridConsump = zeros(400,1);
gridDebt = zeros(400,1);
gridLiq = zeros(400,1);

%% %% 
% Step 2: Divide intervals and compute representative values
for i = 1:nGrids
    % Compute the start and end index of each segment
    startIdx = (i - 1) * gridSize + 1;
    endIdx = min(i * gridSize, nFamilies); % Prevent out-of-bounds errors

    % Take the mean as the representative value (can be changed to median)
    gridWealth(i) = mean(Ill(startIdx:endIdx));
end

% Step 2: Divide intervals and compute representative values
for i = 1:nGrids
    % Compute the start and end index of each segment
    startIdx = (i - 1) * gridSize + 1;
    endIdx = min(i * gridSize, nFamilies); % Prevent out-of-bounds errors

    % Take the mean as the representative value (can be changed to median)
    gridLiq(i) = mean(Liq(startIdx:endIdx));
end

% Step 2: Divide intervals and compute representative values
for i = 1:nGrids
    % Compute the start and end index of each segment
    startIdx = (i - 1) * gridSize + 1;
    endIdx = min(i * gridSize, nFamilies); % Prevent out-of-bounds errors

    % Take the mean as the representative value (can be changed to median)
    gridConsump(i) = mean(total_consump(startIdx:endIdx));
end

% Step 2: Divide intervals and compute representative values
for i = 1:nGrids
    % Compute the start and end index of each segment
    startIdx = (i - 1) * gridSize + 1;
    endIdx = min(i * gridSize, nFamilies); % Prevent out-of-bounds errors

    % Take the mean as the representative value (can be changed to median)
    gridDebt(i) = mean(total_debt(startIdx:endIdx));
end

%% 


