function grids = makegrids(par)
    
    % Unpack parameters
    cellfun(@(x) assignin('caller', x, par.(x)), fieldnames(par));
    
    % Make liquid asset grid
    switch bgrid_type
        case 'Linear'
            grids.b = linspace(bmin,bmax,I)';
        case 'NL_symmetric'
            grids.b = bmin+(1-real(exp((0:I-1)'*1i*pi/(I-1))))*(bmax-bmin)/2;
        case 'NL_lefts'
            grids.b = bmin+(1-real(exp((0:I-1)'*1i*pi/2/(I-1))))*(bmax-bmin);
        case 'NL_rights'
            grids.b = bmin+flip(real(exp((0:I-1)'*1i*pi/2/(I-1))))*(bmax-bmin);
        case'Real1'
            grids.b = w1_liq_real;
            case'Real2'
            grids.b = w2_liq_real;
        otherwise
            grids.b = linspace(bmin,bmax,I)';
    end
    
    % And illiquid asset grid
    switch agrid_type
        case 'Linear'
            grids.a = linspace(amin,amax,J);
        case 'NL_symmetric'
            grids.a = amin+(1-real(exp((0:J-1)*1i*pi/(J-1))))*(amax-amin)/2;
        case 'NL_lefts'
            grids.a = amin+(1-real(exp((0:J-1)*1i*pi/2/(J-1))))*(amax-amin);
        case 'NL_rights'
            grids.a = amin+flip(real(exp((0:J-1)*1i*pi/2/(J-1))))*(amax-amin);
        case 'Real1'
            grids.a = w1_ill_real';
            case 'Real2'
            grids.a = w2_ill_real';
        otherwise
            grids.a = linspace(amin,amax,J);
    end
    grids.d = linspace(8.7340,10.1122, 80);
    % Combined grids
    [grids.aaa, grids.bbb, grids.zzz] = meshgrid(grids.a,grids.b,z);
    %[grids.aaaa, grids.bbbb, grids.zzzz] = meshgrid(grids.a,grids.b,zz);
    grids.ddd = meshgrid(grids.d, grids.b, z);
    %grids.dddd = meshgrid(grids.d, grids.b, zz);
    par.Nz = size(par.state_params, 1); % 现在有8种复合状态

% 创建网格
[grids.aaa, grids.bbb, grids.zzz] = meshgrid(grids.a, grids.b, 1:par.Nz);

% 创建状态参数的三维网格
grids.z_income = grids.aaa;  % 预分配
grids.z_rf = grids.aaa;      % 预分配
grids.z_rh = grids.aaa;      % 预分配

% 填充状态参数网格
for s = 1:par.Nz
    grids.z_income(:,:,s) = par.state_params(s, 1);  % 收入状态
    grids.z_rf(:,:,s) = par.state_params(s, 2);      % 金融资产回报率状态
    grids.z_rh(:,:,s) = par.state_params(s, 3);      % 非金融资产回报率状态
end
    
end