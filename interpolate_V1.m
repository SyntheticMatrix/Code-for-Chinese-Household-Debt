function V1_interp = interpolate_V1(V1_grid, grid_points_liq, grid_points_ill, V_liq, V_ill, w1_liq, w1_ill)
    % 
    %grid_points_liq = linspace(min(w1_liq) , max(w1_liq) , n_points);  
   % grid_points_ill = linspace(min(w1_ill) , max(w1_ill) , n_points);

    F = griddedInterpolant({grid_points_liq, grid_points_ill}, V1_grid, 'linear', 'none');
    
    % 
    V1_interp = F(w1_liq, w1_ill);
end
