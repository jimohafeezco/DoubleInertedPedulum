
function graphs(t,x, x_des, error)
set(0, 'DefaultTextInterpreter', 'latex') 
set(0, 'DefaultLegendInterpreter', 'latex')
figure();

subplot(2,1,1)
% legend("$x_1$, $x_2$", '$x_3$')

hold on;
subplot(2,1,1)
plot(t, (x(:,1)), 'g', 'linewidth', 1.5);
plot(t, (x(:,2)), 'r', 'linewidth', 1.5);
plot(t, (x(:,3)), 'b', 'linewidth', 1.5);
plot(t,x_des(:,1)*ones(size(t)), 'g--');
plot(t,x_des(:,2)*ones(size(t)), 'r--');
plot(t,x_des(:,3)*ones(size(t)), 'b--');
xlabel('Time $t$ [s]');
ylabel('State $x$');
legend("$x_{c}$", '$q_1$', "$q_2$")
grid on
title("States")
hold off
subplot(2,1,2)
hold on
plot(t, error(:,1), 'g', 'linewidth', 1);
plot(t, error(:,2), 'r', 'linewidth', 1);
plot(t, error(:,3), 'b', 'linewidth', 1);
xlabel('Time $t$ [s]');
ylabel('Error $x$');
title("Error")
hold off
grid on;
% figure;
% hold on

grid on;

% legend("cart", "pend1", "pend2")
% hold off
% figure;
% hold on
% % plot(t, u(1), 'linewidth', 1);
% plot(t, u(1), 'linewidth', 1);
% hold off
% plot(t, x_des(:,i), 'b--', 'linewidth', 1);

% plot(x,y*ones(size(x)))

% yline(x_des(:,1), 'b--', 'linewidth', 2);

% hold off;
