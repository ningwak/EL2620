f1 = @(x1,x2) -x2;
f2 = @(x1,x2) x1+(x1.^2-1).*x2;
[X1,X2] = meshgrid(linspace(-3,3,30),linspace(-3,3,30));
F1 = f1(X1,X2);
F2 = f2(X1,X2);
%streamslice(X1,X2,F1,F2)

f = @(x1,x2) [f1(x1,x2);f2(x1,x2)];
V = @(x1,x2) 1.5*x1.^2 + x2.^2 - x1.*x2;
Vdot = @(x1,x2)3*x1*(-x2) + 2*x2*(x1+(x1.^2-1).*x2) -x1*(x1+(x1.^2-1).*x2) - x2*(-x2) % ENTER Vdot HERE;
hold on
fimplicit(Vdot,[-3,3],'linewidth',2)


    