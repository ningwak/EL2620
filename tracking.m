f = @(x,u) sin(x) + u;
k = 0.5;
u = @(x,r,rdot) -sin(x) + rdot - x + r; %ENTER CONTROLLER HERE
r = 1;
rdot = 0;
x0 = 0;
tfinal = 10;
sol  = ode45(@(t,x)f(x,u(x,r,rdot)),[0,tfinal],[x0]);
t = 0:0.1:tfinal;
x = deval(sol,t);
plot(t,x)

d1 = 1;
d2 = 1.5;
f_ref = @(r,rdot,ur) [rdot;-d1*r-d2*rdot+d1*ur];
step = @(t) t>=0;
ur = @(t) step(t)+step(t-5)-2*step(t-10)+step(t-20);

ode45(@(t,x)f_ref(x(1),x(2),ur(t)),[0,tfinal],[0;0]);

x0 = 0;
tfinal = 30;
F = @(x,r,rdot,ur)[f(x,u(x,r,rdot));f_ref(r,rdot,ur)];
sol  = ode45(@(t,y)F(y(1,:),y(2,:),y(3,:),ur(t)),[0,tfinal],[x0;0;0]);
t = 0:0.1:tfinal;
y = deval(sol,t);
x = y(1,:);
r = y(2,:);
rdot = y(3,:);
figure();
plot(t,x,t,r,t,u(x,r,rdot))
legend('x','r','u')