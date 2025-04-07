% Master Control Script: Sequentially execute multiple independent main program scripts

% --------------------------
% User Configuration Section
% --------------------------
scriptsToRun = {    % Specify script filenames in execution order
    'sort_data.m'
    'cross_ana.m'
    'SVAR_main.m'
    
};

% --------------------------
% Configuration Options
% --------------------------
clearBeforeRun = false;   % Clear workspace before each execution
closeFigures = false;     % Close all figures before each execution
pauseDuration = 1;      % Pause duration between scripts (seconds)

% --------------------------
% Execution Engine
% --------------------------
fprintf('\n=== Starting batch execution of %d scripts ===\n', numel(scriptsToRun));

for k = 1:numel(scriptsToRun)
    scriptName = scriptsToRun{k};
    
    % File existence check
    if exist(scriptName, 'file') ~= 2
        fprintf('\n[Warning] Script "%s" not found (%d/%d), skipping...\n', ...
               scriptName, k, numel(scriptsToRun));
        continue;
    end
    
    % Display progress
    fprintf('\n--------------------------------------');
    fprintf('\nExecuting script %d/%d: %s', k, numel(scriptsToRun), scriptName);
    fprintf('\n--------------------------------------\n');
    
    % Environment preparation
    if clearBeforeRun
        clearvars -except scriptsToRun* clear* pause* k  % Preserve control variables
    end
    if closeFigures
        close all  % Close all figure windows
    end
    
    % Script execution with error handling
    try
        tic;  % Start timer
        run(scriptName);
        elapsedTime = toc;
        fprintf('\n[Success] Execution time: %.2f seconds', elapsedTime);
    catch ME
        fprintf('\n[Error] Execution failed: %s\n', ME.message);
    end
    
    % Pause for result inspection
    if pauseDuration > 0
        pause(pauseDuration);
    end
end

fprintf('\n\n=== All scripts completed ===\n');
