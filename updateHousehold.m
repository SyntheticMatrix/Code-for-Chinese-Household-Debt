function [c,d,dbt,sb,sa,vNew,A, cOld,sd] = updateHousehold(V, grids, par, c_index)
    % 1. ================= Initialization =================
    cellfun(@(x) assignin('caller', x, par.(x)), fieldnames(par));
    cellfun(@(x) assignin('caller', x, grids.(x)), fieldnames(grids));
    I = par.I; J = par.J; Nz = 8; aaa = grids.aaa; bbb = grids.bbb; 
    %  (Nz=8)
    state_params = par.state_params;  % 8x3: [z_income, z_rf, z_rh]
    
    % idiosyncratic states (IxJxNz)
    z_income_3d = repmat(reshape(state_params(:,1), [1,1,Nz]), [I,J,1]);
    z_rf_3d = repmat(reshape(state_params(:,2), [1,1,Nz]), [I,J,1]);
    z_rh_3d = repmat(reshape(state_params(:,3), [1,1,Nz]), [I,J,1]);
    
    % 2. ================= Calculation =================
    % zero drifts are assumed to have lower asset returns
    d_zerodrift = -driftilliquid_1(0, aaa, state_params, par);
    
    % Heterogeneous returns 
    Rb_base = 0*(bbb>0) + 0.09*(bbb<0);
    Rb = z_rf_3d;
    w = par.w;
    w2 = par.w2; % for high type
    ra =  z_rh_3d;
    
    [VbF, VbB, VaF, VaB,c_B,c_F] = deal(zeros(I,J,Nz));
    % 3. ================= Derivatives =================
    % 
    VbF(1:I-1,:,:) = (V(2:I,:,:)-V(1:I-1,:,:))./(bbb(2:I,:,:)-bbb(1:I-1,:,:));
    VbB(2:I,:,:)   = VbF(1:I-1,:,:); % backward difference wrt b
    
    VaF(:,1:J-1,:) = (V(:,2:J,:)-V(:,1:J-1,:))./(aaa(:,2:J,:)-aaa(:,1:J-1,:)); % forward difference wrt a
    VaB(:,2:J,:)   = VaF(:,1:J-1,:); % backward difference wrt a
        
    
    % 4. ================= Policy functions =================
    % 
    c_B(2:I,:,:) = (MU_inv(VbB(2:I,:,:), par));
        
c_lin = c_B(:);
c_index = c_index(:);
for i = 2:length(c_lin) 
    if c_lin(i) == 0
        c_lin(i) = c_index(i) + 2;
    end
end


c_B = reshape(c_lin, size(c_B));
c_B(1,:,:) = 0;
    c_F(1:I-1,:,:) = c_B(2:I,:,:);
    
    
    d_idt = 0.0687*aaa; %REALW2
    d_idt = 0.0731*aaa;  %REALW1
    d_idt3 = 0.76*aaa;
    d_idt2 = 0.16*aaa;
    
    
   % Impose the maximum to reflect lumpy non-financial assets
    d_BB = FOC_dPolicy(VaB, VbB, aaa, par.chi0, par.chi1);
    mask = -d_BB > d_idt;
    d_BB(mask) = sign(d_BB(mask)) .* d_idt3(mask);
    d_BF = FOC_dPolicy(VaF, VbB, a, par.chi0, par.chi1);
     %mask = abs(d_BF) > d_idt;
     mask = -d_BF > d_idt;
    d_BF(mask) = sign(d_BF(mask)) .* d_idt3(mask);
    d_FB = FOC_dPolicy(VaB, VbF, a, par.chi0, par.chi1);
     %mask = abs(d_FB) > d_idt;
    mask = -d_FB > d_idt;
     d_FB(mask) = sign(d_FB(mask)) .* d_idt3(mask);
    d_FF = FOC_dPolicy(VaF, VbF, a, par.chi0, par.chi1);
     %mask = abs(d_FF) > d_idt;
     mask = -d_FF > d_idt;
    d_FF(mask) = sign(d_FF(mask)) .* d_idt3(mask);
    
    % Impose the zero drift deposit in cases where the illiquid asset will overrun its state bounds otherwise
    d_FF(:,J,:) = d_zerodrift(:,J,:);
    d_BF(:,J,:) = d_zerodrift(:,J,:);
    d_FB(:,1,:) = d_zerodrift(:,1,:);
    d_BB(:,1,:) = d_zerodrift(:,1,:); 

    % Idenfity whether the conditional deposit policy creates illiquid drift consistent with the conditions used
    I_BB = (d_BB < d_zerodrift);
    I_BF = (d_BF > d_zerodrift);
    I_FF = (d_FF > d_zerodrift);
    I_FB = (d_FB < d_zerodrift);

    % Build deposit policy for backward liquid drift cases, using only consistent deposit policies
    d_B  = d_BF.*I_BF + d_BB.*I_BB + d_zerodrift.*(~I_BB .* ~I_BF);
    d_B(1,:,:) = 0; % This case will never be used, just over-writing a nan when updating d
    
    %EV_B = wageInterpEV(VbB, par.z, par.WN, par.WW);
    %EV_F = wageInterpEV(VbF, par.z, par.WN, par.WW);
    h_B = OptH(VbB, w, par);
    h_F = OptH(VbF, w, par);
    h_B(1,:,:) = 1; h_F(1,:,:);% overwrite
    h_B(h_B>1) = 1; h_F(h_F>1) = 1;
    %hw = WW;
    %xi_B = laborInterpParam(EV_B, hh, hw);
    %xi_F = laborInterpParam(EV_F, hh, hw);
    %EV_B = xi_B.*EV_B;
    %EV_F = xi_F.*EV_F;
    % 5. ================= Drifts =================
    
    sb_B = Rb .* bbb - d_B - adjustmentCost(d_B, aaa, par.chi0, par.chi1)...
           - c_B + h_B.*par.xi.*par.w.*z_income_3d;
    sd_B =  0.2*(c_B - sb_B);
    I_B  = (sb_B < 0); I_B(1,:,:) = 0;
    d_F  = d_FF.*I_FF + d_FB.*I_FB + d_zerodrift.*(~I_FB .* ~I_FF); d_F(I,:,:) = 0;
    sb_F = Rb .* bbb - d_F - adjustmentCost(d_F, aaa, par.chi0, par.chi1)...
           - c_F + h_F.*par.xi.*par.w.*z_income_3d;
       
      I_F  = (sb_F > 0) .* (I_B==0); % Giving precedence to the backward drift if there's a clash
    I_F(I,:,:) = 0;
    sd_F = 0.2*(c_F - sb_F);
    I_0  = 1 - I_B - I_F; % Not representative, will not be displayed
    d_0 = zeros(80, 80, 8);
    d_0 = bdotzero(I_0,VaF,VaB,grids,par);
    c_0  = driftLiquid_1(0,d_0,bbb,aaa,zzz,par);
    c    = c_F.*I_F + c_B.*I_B + c_0.*I_0;

    %c(1,:,:) = c(2,:,:) -0.001;
    d    = d_F.*I_F + d_B.*I_B+ d_0.*I_0;
    h    = h_B.*I_B + h_F.*I_F + 1*I_0;
    %d(1,:,:) = d(2,:,:)+0.001;
    sd   = sd_F.*I_F + sd_B.*I_B + 0*I_0 - 0.0425*(1-par.xi).*par.w.*z_income_3d;
    %sb   = driftLiquid_1(c,d,bbb,aaa,zzz,par);
    sb = Rb .* bbb - d - adjustmentCost(d, aaa, par.chi0, par.chi1)...
           - c + h.*par.xi.*par.w.*z_income_3d;
    sb   = sb - 0.4*sd;
    
    sa = ra .* aaa + d;
   
    dbt_F = c_F - sb_F; dbt_B = c_B - sb_B; dbt_0 = c_0 - c_0;
   
    dbt = dbt_F.*I_F + dbt_B.*I_B; +dbt_0.*I_0;
    dbt = 0.2*dbt;
    % 6. ================= Transition Matrix =================
    %
    A = driftMatrixLiquid(sb, bbb, par) + ...
        driftMatrixIlliquid(sa, aaa, par) + ...
        par.Bswitch_composite;  %  8x8 composite matrix
    
    % 7. ================= Value function update =================
    % 
    B = (1/Delta + rho)*speye(I*J*8) - A;
    u_stacked = reshape(U(c, par), I*J*8, 1);
    V_stacked = reshape(V, I*J*8, 1);
    
    vec = u_stacked + V_stacked/Delta;
    
    
    vNew = reshape(B\vec, I, J, 8);
    cOld = c;
end