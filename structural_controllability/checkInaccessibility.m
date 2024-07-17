%define function inaccessible and dilation

function isInaccessible = checkInaccessibility(A, B, i)
    % checkInaccessibility checks if the i-th state in the state-space system
    % (A, B) is inaccessible
    %
    % Inputs:
    % - A: State matrix (n x n)
    % - B: Input matrix (n x m)
    % - i: Index of the state to check (1-based index)
    %
    % Output:
    % - isInaccessible: Boolean value (true if the i-th state is inaccessible, false otherwise)
    %
    
    % Number of states
    n = size(A, 1);
    
    % Number of inputs
    m = size(B, 2);
    
    % Create a directed graph from the adjacency matrix [A, B]
    %adjMatrix = [A, B];
    adjMatrix = A;

    % Initialize the reachability array
    reachable = false(1, n);
    
    % Perform a breadth-first search (BFS) from each input vertex
    for col = 1:m
        if any(B(:, col))
            queue = find(B(:, col));  % start BFS from non-zero entries in B
            while ~isempty(queue)
                current = queue(1);
                queue(1) = [];
                if ~reachable(current)
                    reachable(current) = true;
                    %current
                    %neighbors = find(adjMatrix(current, :) > 0);
                    neighbors = find(adjMatrix(:, current) ~= 0);
                    %reachable
                    %reachable(neighbors)
                    queue = [queue, neighbors(~reachable(neighbors))];
                end
            end
        end
    end
    reachable
    % Check if the i-th state is reachable
    isInaccessible = ~reachable(i);
end
