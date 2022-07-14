s = tf('s');
T = 1;
G = 1/(1+s*T)/s;
Flead  = (1+2*s)/(1+0.5*s);
h = nyquistplot(4*G,G,0.25*G,4*G*Flead);
set(h,'ShowFullContour','off');
xlim([-5,0])
ylim([-5,0])
hold on
D = 0.2;
A  = D:0.01:10;
Nbacklash = (1/pi*(pi/2+asin(1-2*D./A)+2*(1-2*D./A).*sqrt(D./A.*(1-D./A)))-1i*4*D./A/pi.*(1-D./A));
plot(real(-1./Nbacklash),imag(-1./Nbacklash),'g')
legend('K=4','K=1','K=0.25','K=4(1+2s)/(1+0.5s)','-1/N(A)','interpreter','latex','location','northwest')
