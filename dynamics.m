%% This is our equation to integrate (solve):
function dstate = dynamics(t, state, system, controller)

l1 = system.l1;
l2= system.l2;
l3= system.l3;
m1 = system.m1;
m2= system.m2;
m3= system.m3;
b= system.b;
k=system.b;

% Extract states
x1 = state(1); 
x2 = state(2); 
x3= state(3);
dx1 = state(4); 
dx2 = state(5); 
dx3 = state(6);
dx = [dx1; dx2;dx3];

% Find 'Inertia matrix'
d1 = m1+m2+m3;
d2= (0.5*m1+m2)*l1;
d3= 0.5*m2*l2;
d4= (1/3*m1+m2)*l1^2;
d5=0.5*m2*l1*l2;
f1= ((0.5*m1)+m2)*l1*10;
f2= 0.5*m2*l2*10;
d6= 1/3*m2*l2^2;

% Find nonlinear function 
 
D = [d1,   d2*cos(x2),    d3*cos(x3);
    d2*cos(x2),    d4,     d5*cos(x2-x3);
    d3*cos(x3),      d5*cos(x2-x3),    d6];

beta = [-d2*sin(x2)*dx2^2-d3*sin(x3)*(dx3^2);
        d5*sin(x2-x3)*(dx3^2)-f1*sin(x2);
        -d5* sin(x2-x3)*dx2^2-f2*sin(x3)];
 
 
% Control input implimented as external function of state
[u, x_des] = control(t, state, controller);

% Equation for second order derevitive
% ddx = D\(u- beta);
ddx = D\(u-beta);

% Combine dx, ddx back to time derevitive of state
dstate = [dx1; dx2; dx3; ddx]; 
end