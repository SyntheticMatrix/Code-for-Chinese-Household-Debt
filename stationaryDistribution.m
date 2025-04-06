function [g, dadbdz] = stationaryDistribution(A, a, b, par, type)

    if nargin < 5
        type = 'measure';
    end

    % Unpack parameter values
    I = par.I; J = par.J; Nz = par.Nz; M = I*J*Nz;
    
    
    % Building a matrix of da * db for aggregation
    db = ones(I,1); da = ones(J,1);

    db(2:I-1) = (b(3:I) - b(1:I-2))/2;
    db(1)     = (b(2) - b(1))/2;
    db(I)     = (b(I) - b(I-1))/2;
    
    assert(sum(db) - (par.bmax - par.bmin) < 1e-10, 'Accumulated db do not equal the range of b')

    da(2:J-1) = (a(3:J) - a(1:J-2))/2;
    da(1)     = (a(2) - a(1))/2;
    da(J)     = (a(J) - a(J-1))/2;
    
    dadbdz    = repmat(db * da', 1,1,Nz);

    % Fix one value so matrix isn't singular:
    vec        = zeros(M,1);
    iFix       = I*J-2;
    vec(iFix)  = 1e-8;
    AT         = A'; 
    AT(iFix,:) = [zeros(1,iFix-1),1,zeros(1,M-iFix)];
    
    % Solve system & rebase
    g_stacked = AT\vec;
    g = reshape(g_stacked/sum(g_stacked), I, J, Nz); % returns the measure

    % convert histogram to density
    if (type == 'density')
        g = g ./ dadbdz;
    end
        
end
