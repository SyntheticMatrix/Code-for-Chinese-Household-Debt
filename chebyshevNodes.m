%% 改进的节点生成（含边界处理）
function nodes = chebyshevNodes(n, range, varargin)
    p = inputParser;
    addOptional(p, 'endpoint', false);
    parse(p, varargin{:});
    
    b_min = range(1);
    b_max = range(2);
    
    if p.Results.endpoint
        k = 0:n-1;
        nodes = cos(pi*k/(n-1))';
    else
        k = 1:2:(2*n-1);
        nodes = cos(pi*k/(2*n))';
    end
    
    nodes = 0.5*((b_max - b_min)*nodes + (b_max + b_min));
end