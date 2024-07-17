% Define state-space matrices A and B
A = [0 1 0 0; 0 0 1 0; -1 -1 -1 0; 0 0 0 1];
B = [1; 0; 0; 1];

% Index of the state to check (1-based index)
i = 3;
% 
% % Check if the i-th state is inaccessible
% inaccessible = checkInaccessibility(A, B, i);
% 
% % Display the result
% if inaccessible
%     fprintf('The state x%d is inaccessible.\n', i);
% else
%     fprintf('The state x%d is accessible.\n', i);
% end


% Check if the system has dilation
flag = LinControllability(A, B);

% Display the result
if flag
    fprintf('The system is structurally controllable.\n');
else
    fprintf('not structurally controllable.\n');
end
