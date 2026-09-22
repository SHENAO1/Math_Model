clc
clear
close all
x1=[200,146.12,78.23,21.27,0];x1=fliplr(x1);
y1=[850,819.43,637.13,322.14,0];y1=fliplr(y1);
x2=[200,204.29,141.30,51.17,23.92,0,-88.98,-107.88,-60.71];x2=fliplr(x2);
y2=[850,883.00,898.50,865.55,752.79,557.97,340.80,137.38,0];y2=fliplr(y2);
x1i=0:1:200;y1i=interp1(x1,y1,x1i,'pitch');
plot(x1i,y1i,'k-');
hold on
plot(x2,y2,'k.','MarkerSize',20);
x21=x2(1:7);y21=y2(1:7);
y21i=0:1:898;x21i=interp1(y21,x21,y21i,'pchip');
% plot(x21i,y21i);
x22=x2(7:9);y22=y2(7:9);
y22i=898:-1:850;x22i=interp1(y22,x22,y22i,'pchip');
% plot(x22i,y22i);
x2i=[x21i,x22i];
y2i=[y21i,y22i];
plot(x2i,y2i,'k--');
%--------------------Í¼Ïñ´¦Àí
grid on
axis([-150,250,0,950])
xlabel('H/mm','FontSize',16);
ylabel('V/mm','FontSize',16);
x3=x1(1:4);x3=x3-49.3;
y3=y1(1:4);y3=y3+10;
x3=[x3,x1(end)];y3=[y3,y1(end)+20];
x3i=-50:10:200;y3i=interp1(x3,y3,x3i,'pitch');
plot(x3i,y3i,'k.-');
legend('Cruve S_1','Feature Points','Cruve S_2','Cruve S^/_2','location','best');

