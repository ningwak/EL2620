f = @(x,u) [x(2,:);u];
a = 1 % ENTER CODE HERE
% s = @(x) a*x(1,:)+x(2,:);% ENTER CODE HERE
s = @(x) sin(a*x(1,:))+x(2,:);
k = 10 % ENTER CODE HERE
sat = @(u)min(1,max(-1,u));
% u = @(x) -a*x(2,:) - k*sat(s(x)/0.01) % ENTER CODE HERE
u = @(x) -a*cos(a*x(1,:)).*x(2,:) - k*sat(s(x)/0.01)
x0 = [1;0];
tfinal = 5;
sol = ode45(@(t,x)f(x,u(x)),[0,tfinal],x0);
t = sol.x;
x = sol.y;


fimplicit(@(x1,x2)s([x1;x2]),[-1,1],'--')

figure();
plot(t,x(1,:),t,x(2,:));
legend('x1','x2');
figure();
plot(t,u(x));
figure();
plot(t,s(x));