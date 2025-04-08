function Phi_derivative = chebyshev_derivative(nodes, order, interval)
    
    scaled_nodes = 2*(nodes - interval(1))/(interval(2)-interval(1)) - 1; 
    Phi_derivative = zeros(length(nodes), order+1);
    for k = 0:order
        if k == 0
            Phi_derivative(:,k+1) = zeros(size(nodes));
        else
            Phi_derivative(:,k+1) = k * sin(k * acos(scaled_nodes)) / sqrt(1 - scaled_nodes.^2);
        end
    end
    
    scale_factor = 2/(interval(2)-interval(1));
    Phi_derivative = Phi_derivative * scale_factor;
end