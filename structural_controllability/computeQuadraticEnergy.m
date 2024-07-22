function u_optimal = computeQuadraticEnergy(A, B, xi, xt, T)
    % This function computes the quadratic energy input required to move
    % the system from the initial state xi to the target state xt.
    %
    % Inputs:
    %   A  - State matrix
    %   B  - Input matrix
    %   xi - Initial state vector
    %   xt - Target (desired) state vector
    %   T  - Final time for control (optional, default is 5)
    %
    % Output:
    %   E  - Quadratic energy input

    % Default final time if not provided
    if nargin < 5
        T = 5;
    end

    % Compute the controllability Gramian
    Wc = gram(ss(A, B, [], []), 'c');

    % Compute the inverse of the controllability Gramian
    inv_Wc = inv(Wc);

    % Define a time vector for simulation
    t = linspace(0, T, 100); % Adjust the time vector as needed
    dt = t(2) - t(1);

    % Preallocate the control input array
    u_optimal = zeros(size(B, 2), length(t));

    % Compute the optimal control input u(t) for each time step
    for k = 1:length(t)
        tau = t(k);
        u_optimal(:, k) = B' * expm(A' * (T - tau)) * inv_Wc * (xt - expm(A * T) * xi);
    end

    % Compute the quadratic energy input
    E = trapz(t, sum(u_optimal.^2, 1));

    % Optional: Plot the control input over time
    % figure;
    % plot(t, u_optimal);
    % xlabel('Time (s)');
    % ylabel('Control Input u(t)');
    % title('Optimal Control Input over Time');
    % grid on;
    
    % Display the result
    fprintf('The quadratic energy input is: %f\n', E);
end

