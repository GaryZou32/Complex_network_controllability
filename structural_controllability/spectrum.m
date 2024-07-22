A=[-3.2 1.3 1; 1.3 -2.7 0.7; 1 0.7 -2.2];
B=[1; 0; 0];


% Define the initial and desired states
x0 = [0; 0; 0];
xd = [0; 0; 1];

t = linspace(0, 1, 100);

E1=computeQuadraticEnergy(A,B,x0,xd,1);
E2=computeQuadraticEnergy(A,B,x0,[0; 1; 0],1);
E3=computeQuadraticEnergy(A,B,x0,[1; 0; 0],1);

figure;
plot(t, E3);
xlabel('Time (s)');
ylabel('Control Input u(t)');
title('Optimal Control Input over Time');
grid on;
hold on
plot(t, E2);
plot(t, E1);