function hasDilation = checkDilation(A, B)
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

    % Find the origins (input vertices)
    origins = find(any(B, 2));

    % Compute the transitive closure of A
    transitiveClosure = transitiveClosureMatrix(A);

    % Iterate over all subsets of states, skipping subsets with origins
    for subsetSize = 1:n-1
        subsets = nchoosek(1:n, subsetSize);
        for j = 1:size(subsets, 1)
            S = subsets(j, :);

            % Exclude origins from S
            S = setdiff(S, origins);

            % Skip if S is empty after removing origins
            if isempty(S)
                continue;
            end

            % Compute T(S) for the current subset S
            T_S = find(any(transitiveClosure(:, S), 2))';

            % Check if |T(S)| < |S|
            if length(T_S) < length(S)
                hasDilation = true;
                return;
            end
        end
    end

    % If no dilation is found
    hasDilation = false;
end

function tc = transitiveClosureMatrix(A)
    % Compute the transitive closure of the adjacency matrix A using the Floyd-Warshall algorithm
    n = size(A, 1);
    tc = A ~= 0;

    for k = 1:n
        for i = 1:n
            for j = 1:n
                tc(i, j) = tc(i, j) || (tc(i, k) && tc(k, j));
            end
        end
    end
end

% Instead of explicitly generating and evaluating all subsets, we can use the following optimizations:
% 
% Graph Representation: Represent the state-space system as a directed graph.
% Transitive Closure: Compute the transitive closure of the graph to efficiently determine reachability.
% Hall's Condition: Use Hall's marriage theorem to check for dilations. Hall's condition states that a bipartite graph has a perfect matching if and only if for every subset 
% 𝑆
% S of one part, the neighborhood of 
% 𝑆
% S has at least as many vertices as 
% 𝑆
% S.

% Explanation
% Transitive Closure:
% 
% The transitiveClosureMatrix function computes the transitive closure of the adjacency matrix 
% 𝐴
% A. The transitive closure helps in determining the reachability between any pair of nodes efficiently.
% Iterate Over Subsets:
% 
% Instead of iterating over all subsets, subsets that include origins are immediately skipped.
% For each subset 
% 𝑆
% S, the neighborhood 
% 𝑇
% (
% 𝑆
% )
% T(S) is computed using the transitive closure matrix. This ensures that we only consider reachable nodes.
% Check Hall's Condition:
% 
% For each subset 
% 𝑆
% S, check if 
% ∣
% 𝑇
% (
% 𝑆
% )
% ∣
% <
% ∣
% 𝑆
% ∣
% ∣T(S)∣<∣S∣. If such a subset is found, the function immediately returns true indicating a dilation exists.
% If no such subset is found, the function returns false.
% Optimizations
% Transitive Closure: Using the Floyd-Warshall algorithm for computing the transitive closure ensures that reachability queries are efficient.
% Subset Evaluation: Skipping subsets that contain origins and leveraging the transitive closure matrix reduces the computational burden compared to the naive approach.

