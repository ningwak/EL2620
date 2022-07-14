K=5;  % Change controller gain K here
deadzone = @(x) (x<-1).*(x+1) + (x>1).*(x-1);
s=tf('s');
G = sqrt(2)/((s^2+s+1)*(s+1));
G=ss(G);
step = @(t)(t>0);
r = @(t)10*(step(t-10)-step(t-30));
tspan = [0,100];
x0=[0;0;0];
f_closed=@(t,x)G.a*x+G.b*deadzone(r(t)-K*G.c*x);
sol = ode45(f_closed,tspan,x0);
t = 0:0.1:sol.x(end);
x = deval(sol,t);
figure();
plot(t, x(1,:));
nyquist(G)