% This is main file for simulation, post processing and plotting
clc; % Clears all the text from the Command Window.
clear all;close all;
 % Remove items from workspace, freeing up system memory
% Set system parameters
m1 = 2;m2=1; m3=1;
l1= 1; l2 =1; l3=1;
% Combine parameters to a struct 'system'
xdes=-5; ydes=1.5;

q2traj1= cos((xdes^2+ydes^2-l1^2-l2^2)/(2*l1*l2));
% sq2= sqrt(1-cq2^2);

% q2traj1= atan2(sq2,cq2);

% q2traj1= atan2(sq2,cq2);
q1traj1 = atan(ydes/xdes)+atan((l2*sin(q2traj1))/(l1+l2*cos(q2traj1)));

q1traj= +pi/2-q1traj1;
q2traj= pi/2-q1traj1-q2traj1;

xcart = xdes-l1*sin(q1traj)-l2*sin(q2traj);
% 
% xcart= 5;
% q1traj= deg2rad(180);
% 
% q2traj= pi/3;

system.l1 =l1;
system.l2=l2;
system.l3=l3;
system.m1=m1;
system.m2=m2;
system.m3=m3;
% Controller parameters
d =0;
b=diag([d, d, d]);
% k=10;

x_des(:,1) = xcart;
x_des(:,2) = q1traj;
x_des(:,3) = q2traj;
omega = 10;
% k1 = [0, omega^2, omega^2; 0 0 0; 0 0 0];
% k2 = [0, omega*2, omega*2; 0 0 0; 0 0 0];
k2 = diag([omega*2, omega*2, omega*2]);
k1 =  diag([omega^2, omega^2, omega^2]);
% k1 = diag([omega^2, omega^2, omega^2]);
% k2 =  [omega*2, omega*2, omega*2];

% k1 = []
controller = system;
controller.k1 = k1;
controller.k2 = k2;
controller.l1 = l1;
controller.l2 = l2;
controller.m1=m1;
controller.m2=m2;
controller.m3=m3;
controller.lambda = k2;
controller.m_bounds = [0.2 1.5];
controller.m1_bounds = [6 12];
controller.l_bounds = [2.5  3.2];
controller.xcart = xcart;
controller.q1traj = q1traj;
controller.q2traj = q2traj;
system.b= b;
controller.b= b;
% system.b= k;

% Trajectory params

a0=180;
b0=180;
x20= deg2rad(a0);
x30= deg2rad(b0);

% Time settings
t0 = 0;
tf = 10;
dt = 0.01;
% Integration (simulation)
% Create a time vector for numerical integration
tspan = [t0:dt:tf]; 
% Set a vector of initial conditions x0 = [theta_0 dthetadt_0]
x0 = [1, x20,x30, 0.0, 0.0, 0.0]; 
% Run a solver to integrate our differential equations
[t,x] = ode45(@(t,x)dynamics(t, x, system, controller), tspan, x0);
% t - vector of time 
% x - solution of ODE (value of evalueted integral in time span t)

% Calculate control and desired trajectory for solution
[u, x_des] = control(t, x, controller);

% Calculate error 
for i = 1:3
    error(:,i) = x_des(:,i) - x(:,i);
end

% plot scripts start here

graphs(t,x, x_des, error)

close all;
for k=1:length(t)
    drawPlot(x(k,:),m1,l1, l2,t, xdes, ydes);
end




