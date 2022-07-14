k1 = 0.5;
f1 = @(x1,x2) sin(x1)+x2;
phi = @(x1)-k1*x1-sin(x1);
tf = 10;
x10 = 10;
sol = ode45(@(t,x1)f1(x1,phi(x1)),[0,tf],x10);
t = linspace(0,tf,200);
x1 = deval(sol,t);
figure(1)
plot(t,x1,t,phi(x1))
hold on
xlabel('t')
grid

figure(2)
plot(x1,phi(x1))
hold on
V1 = @(x1) x1.^2/2;
fcontour(@(x1,x2)V1(x1),[-5,10,-8,4])
xlabel('x_1')
ylabel('x_2')
grid

k2 = 100;
f2 = @(x1,x2,u) u;
f = @(x1,x2,u)[f1(x1,x2);f2(x1,x2,u)];
z = @(x1,x2) x2 - phi(x1); % DEFINE Z HERE, PHI IS ALREADY DEFINED ABOVE
u = @(x1,z) -k1.*x1-(cos(x1) + k1).*(-k1.*x1 + z) - k2.*z; % DEFINE U HERE AS FUNCTION OF X1 and Z
x0 = [x10;phi(x10)];
sol = ode45(@(t,x)f(x(1),x(2),u(x(1),z(x(1),x(2)))),[0,tf],x0);
x = deval(sol,t);
figure(1)
plot(t,x(1,:),t,x(2,:),'linewidth',2)
figure(2)
plot(x(1,:),x(2,:),'linewidth',2)
V = @(x1,z) V1(x1)+z.^2/2;
fcontour(@(x1,x2)V(x1,z(x1,x2)),[-5,10,-8,4],'linewidth',1)

figure(3)
plot(x(1,:),z(x(1,:),x(2,:)))
xlabel('x_1')
ylabel('z')
hold on
fcontour(V)
grid

figure(4)
plot(t,phi(x1),t,x(2,:),t,u(x(1,:),z(x(1,:),x(2,:))))