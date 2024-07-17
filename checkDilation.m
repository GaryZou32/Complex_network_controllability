
function hasDilation = checkDilation(A, B)
    %this function seems to computationally expensive
    % checkDilation checks if the state-space system (A, B) contains a dilation
    %
    % Inputs:
    % - A: State matrix (n x n)
    % - B: Input matrix (n x m)
    %
    % Output:
    % - hasDilation: Boolean value (true if the system contains a dilation, false otherwise)
    %
    
    % Number of states
    n = size(A, 1);

    % Initialize the result as false
    hasDilation = false;
    
    % Find the origins (input vertices)
    origins = find(any(B, 2));
    
    % Iterate over all possible subsets S of the set of states (excluding the empty set)
    for sSize = 1:(n-1)
        subsets = nchoosek(1:n, sSize);
        for k = 1:size(subsets, 1)
            S = subsets(k, :);
            
            % Exclude origins from S
            S = setdiff(S, origins);
            
            % Skip if S is empty after removing origins
            if isempty(S)
                continue;
            end
            
            % Compute T(S) for the current subset S
            T_S = [];
            for s = S
                T_S = union(T_S, find(A(s, :) ~= 0));
            end
            
            % Check if |T(S)| < |S|
            if length(T_S) < length(S)
                hasDilation = true;
                return;
            end
        end
    end
end

