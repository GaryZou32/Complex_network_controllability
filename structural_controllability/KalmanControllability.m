function isControllable = KalmanControllability(A, B)
    % KalmanControllability checks if the state-space system (A, B) is controllable
    %
    % Inputs:
    % - A: State matrix
    % - B: Input matrix
    %
    % Output:
    % - isControllable: Boolean value (true if controllable, false otherwise)
    %
    
    % Number of states
    n = size(A, 1);
    
    % Initialize the controllability matrix
    C = B;
    
    % Construct the controllability matrix
    for i = 1:n-1
        C = [C, A^i * B];
    end
    
    % Check if the controllability matrix has full rank
    isControllable = (rank(C) == n);
end
