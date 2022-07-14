alpha = 1;
A = [alpha -1;1 0];% ENTER YOUR MODEL HERE
B = [1;0]
C = [1 0]
G = ss(A,B,C,0);
phi = @(y) alpha*y.^3;
f = @(x) A*x+B*phi(-C*x);
x0 = [1;0];
tf = 50;
sol = ode45(@(t,x)f(x),[0,tf],x0);
t=linspace(0,tf,1000);
x = deval(sol,t);
y = C*x;
subplot(2,1,1)
plot(t,y)
xlabel('t')
ylabel('y(t)')
subplot(2,1,2)
plot(x(1,:),C*(A*x+B*phi(-C*x)))
xlabel('$y(t)$','interpreter','latex')
ylabel('$\dot y(t)$','interpreter','latex')

syms A wt alpha
b1 = int(alpha*(A*sin(wt))^3*sin(wt),wt,[0,2*pi])
N = matlabFunction(b1/A) %ENTER DESCRIBING FUNCTION HERE
figure();
a = 0.2:0.01:10;
N(a,1)
nyquist(G)
hold on;
plot(real(-1./N(a,alpha)),imag(-1./N(a,alpha)),'g')
figure();
bode(G)