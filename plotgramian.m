% Define state-space matrices A and B
A = [-1 0 0; 0 -1 0; 0 0 -1];
B = [1; 0; 0];

% Create state-space system
sys = ss(A, B, [], []);

% Compute the controllability Gramian
Wc = gram(sys, 'c');

% Plot the Gramian matrix using imagesc
figure;
imagesc(Wc);
colorbar;
title('Controllability Gramian');
xlabel('State Index');
ylabel('State Index');

% Plot the Gramian matrix using surf
figure;
surf(Wc);
colorbar;
title('Controllability Gramian');
xlabel('State Index');
ylabel('State Index');
zlabel('Value');
