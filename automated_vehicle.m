clear variables
close all

% Uni-cycle model; states x, y, theta; inputs v and omega
f = @(x,y,theta,v,omega)[v.*cos(theta);v.*sin(theta);omega];

% Reference generation
% Case 1, lane changes on straight road
vx = 10; % m/s
xr = @(t) cos(t);
dxr = @(t) -sin(t);
ddxr = @(t) -cos(t);
yr = @(t) cos(4*t); % switch between 0 and 3 m, right and left lane every 5 seconds
dyr = @(t) -4*sin(4*t);
ddyr= @(t) -16*cos(4*t);

vr = @(t) sqrt((dxr(t)).^2 + (dyr(t)).^2);
omegar = @(t) (dxr(t).*ddyr(t) - dyr(t).*ddxr(t))./((dxr(t)).^2 + (dyr(t)).^2);
thetar = @(t) atan2(dyr(t),dxr(t));

% Error variables
xe = @(t,x,y,theta) cos(theta).*(xr(t)-x) + sin(theta).*(yr(t)-y);
ye = @(t,x,y,theta) -sin(theta).*(xr(t)-x) + cos(theta).*(yr(t)-y);
thetae = @(t,x,y,theta) wrapToPi(thetar(t)-theta);

% Controller tuning
eta = 1;
b = 0.4;
% Controller parameters
k1 = @(t) 2*eta*sqrt(omegar(t).^2 + b*vr(t).^2);
k2 = b;
k3 = k1;

% Controller
v = @(t,x,y,theta) vr(t).*cos(thetae(t,x,y,theta)) + k1(t).*xe(t,x,y,theta);
omega = @(t,x,y,theta) omegar(t) + k2.*vr(t).*(sinc(thetae(t,x,y,theta)/pi)).*ye(t,x,y,theta) + k3(t).*thetae(t,x,y,theta);

% Simulation
z0 = [0;0;0];
tfinal = 50;
sol = ode45(@(t,z)f(z(1,:),z(2,:),z(3,:),v(t,z(1,:),z(2,:),z(3,:)),omega(t,z(1,:),z(2,:),z(3,:))),[0,tfinal],z0);
t = 0:0.1:tfinal;
z = deval(sol,t);

% Plot results
figure(1)
plot(z(1,:),z(2,:),xr(t),yr(t))
xlabel('x [m]')
ylabel('y [m]')
legend('path','reference path')

figure(2)
plot(t,v(t,z(1,:),z(2,:),z(3,:)),t,vr(t))
xlabel('time [s]')
ylabel('velocity [m/s]')
legend('v','vref')

figure(3)
plot(t,omega(t,z(1,:),z(2,:),z(3,:)),t,omegar(t))
xlabel('time [s]')
ylabel('yaw rate [rad/s]')
legend('omega','omega ref')

figure(4)
plot(t,z(3,:),t,thetar(t))
xlabel('time [s]')
ylabel('Heading (yaw) [rad]')
legend('theta','thete ref')