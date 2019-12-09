x = logspace(-1,1,100);
y = x.^2;
subplot(2,2,1);
plot(x,y);
title('Plot');
set(gca,'XGrid','on');
subplot(2,2,2);
semilogx(x,y);
title('Semilogx');
set(gca,'XGrid','on');
subplot(2,2,3);
semilogy(x,y);
set(gca,'XGrid','on');
title('Semilogy');
subplot(2,2,4);
loglog(x, y);
title('Loglog');
set(gca,'XGrid','on');