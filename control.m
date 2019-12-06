%% This is control function:
function [u, x_des] = control(t, state, controller)



% Extract states
x1 = state(1); 
x2 = state(2); 
x3= state(3);
x = [x1, x2, x3];

dx1 = state(4); 
dx2 = state(5); 
dx3 = state(6);
dx = [dx1, dx2, dx3];
l1 = controller.l1;
l2= controller.l2;
xcart=controller.xcart ;
q1traj = controller.q1traj;
q2traj= controller.q2traj;


x_des(:,1) = xcart;
x_des(:,2) = q1traj;
x_des(:,3) = q2traj;

dx_des(:,1) = 0;
dx_des(:,2) = 0;
dx_des(:,3) = 0;

ddx_des(:,1) = 0;
ddx_des(:,2) = 0;
ddx_des(:,3) = 0;

e = x_des - x;
de = dx_des - dx;

% Extract PD gains
k1 = controller.k1;
k2 = controller.k2;
m1 = controller.m1;
m2 = controller.m2;
m3 =controller.m3;
% m_bounds =controller.m_bounds;
% m1_bounds =controller.m1_bounds;
% m1 = mean(m1_bounds);
% m2 = mean(m_bounds);
% m3 = mean(m_bounds);
l1= controller.l1;
l2= controller.l2;
b= controller.b;


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

    
    
lambda = controller.lambda;

z = de' +lambda *e';
rho=10;
eps =0.1;
if norm(z)== eps
   w =rho*z/norm(z);
else   
   w = rho*z/norm(z); 
end

u_star = k1*e' + k2*de';


    
    % Your controller goes here
% u=1;
% control 1

% u_star = k1*e' + k2*de';

u_star = k1*e' + k2*de' + ddx_des';
u = D*u_star + beta;
% u=0;
% control 2
% u = k1*e' + k2*de';
% u = 0;
% u=3;
% u = k1*e' +k2* de';
% u = [u_all(1),0, 0]';
% u = [u(1),0, 0]';

end