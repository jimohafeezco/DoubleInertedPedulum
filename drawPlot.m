function drawPlot(x,m,l1, l2,t, x_des, y_des)
x0 = 1;
theta = x(:,2);
theta1 = x(:,3);
xpos = x(:,1);
mr = .3*sqrt(m); % mass radius
W =2;
H=0.4;
y = 0.2;

px = xpos +l1*sin(theta);
py = y+l1*cos(theta);
px2= px+l2*sin(theta1);
py2= py+l2*cos(theta1);
plot([-10 10],[0 0],'w','LineWidth',2)
hold on
rectangle('Position',[xpos-W/2,y,W,H],'Curvature',.1,'FaceColor',[1 0.1 0.1],'EdgeColor',[1 1 1])
grid on
plot([xpos px],[y py],'b','LineWidth',2)
plot([px px2],[py py2],'r','LineWidth',2)
plot(x_des,y_des,'g*')
% rectangle('Position',[px-mr/2,py-mr/2,mr,mr],'Curvature',1,'FaceColor',[.3 0.3 1],'EdgeColor',[1 1 1])
axis equal
% set(gca,'YTick',[])
% set(gca,'XTick',[])
xlim([-10 10]);
ylim([-10 10]);
set(gca,'Color','k','XColor','w','YColor','w')
set(gcf,'Position',[10 900 800 400])
set(gcf,'Color','k')
set(gcf,'InvertHardcopy','off')   

% box off
drawnow
hold off


% 
% figure();
% % subplot(2,1,1)
% hold on;
% plot(t, rad2deg(x(:,1)), 'g', 'linewidth', 1);
% plot(t, rad2deg(x(:,2)), 'r', 'linewidth', 2);
% plot(t, rad2deg(x(:,3)), 'b', 'linewidth', 1);
% grid on;
% 
% 
