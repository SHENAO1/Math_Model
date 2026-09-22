clc
clear
x=[200,146.12,78.23,21.27,0];
y=[850,819.43,637.13,322.14,0];
plot(x,y,'k.','MarkerSize',20);
box=-10;
boy=-50;
% axis equal
axis([box,220,boy,880]);
hold on
xi=0:1:200;
yi=interp1(x,y,xi,'pitch');
plot(xi,yi,'k--');
grid on
legend('Feature Points','Cruve S1','location','best','FontSize',16);
xlabel('H/mm','FontSize',16);
ylabel('V/mm','FontSize',16);