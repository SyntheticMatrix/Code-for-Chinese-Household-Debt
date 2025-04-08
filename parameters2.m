function par = parameters2()

    % Preferences
    par.gamma  = 2;
    par.rho    = 0.05;

    % Prices
    par.ra     = 0.02;
    par.rb_pos = 0.015;
    par.rb_neg = par.rb_pos + 0.09;
    par.w      = 4.0;

    % Illiquid asset parameters
    par.chi0   = 0.03; % Linear adjustment cost
    par.chi1   = 2; % Convex adjustment cost
    par.xi     = 0.1; % Automatic proportion of labour earnings to illiquid

    % Asset grid settings
   % par.I      = 80;
   % par.bmin   = -2.0;
   % par.bmax   = 50.0;

   % par.J      = 70;
   % par.amin   = 0.000001;
   % par.amax   = 100.0;
    par.I      = 40;
    par.bmin   = 5.67083692539137;
    par.bmax   = 9.85244565848604;
  % par.bmin   = 9.7615;
   %par.bmax   = 13.8691;
    
    par.J      = 40;
    par.amin   = 6.78622252229580;
    par.amax   = 11.2119145649019;
   % par.amin   = 11.3479;
  %  par.amax = 16.0313;
    % Exogenous state settings
    par.z      = [0.8,1.3];
    par.Nz     = length(par.z);
    par.la_mat = [-0.33333, 0.33333; 0.33333, -0.33333];
    par.Bswitch= kron(par.la_mat, speye(par.I*par.J));

    % Grid types: you can choose from
    % 'Linear'       = equispaced
    % 'NL_symmetric' = nonlinear with concentration of points on both ends,
    % 'NL_lefts'     = nonlinear grid with concentration of points at the left end (lower bound),
    % 'NL_rights'    = nonlienar grid with concentration of points at the right end
    par.bgrid_type = 'NL_lefts';
    par.agrid_type = 'NL_lefts';

    % Estimation parameters
    par.crit  = 1e-5;
    par.Delta = 1e8;
    par.maxit = 3500;

end
