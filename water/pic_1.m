f1 = @(x) x.^2;
x = (1:0.025:2);
plot(x,f1(x),'k',x,sin(2*pi*x),'or')
legend('t^{2}','sin(2\pi,t)')
xlabel('Time(ms)')
ylabel('f(t)')
title('Mini Assignment#1')