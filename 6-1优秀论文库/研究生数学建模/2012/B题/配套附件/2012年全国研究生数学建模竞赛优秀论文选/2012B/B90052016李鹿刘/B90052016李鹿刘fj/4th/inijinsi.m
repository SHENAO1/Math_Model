function state_ini=inijinsi(x,h)
%%%下一时刻线性方程组的初值
%%%h为步长
state_ini=x;
state_ini(1)=x(1)+x(4)*h;%+x(7)*h^2/2;
state_ini(2)=x(2)+x(5)*h;%+x(8)*h^2/2;
state_ini(3)=x(3)+x(6)*h;%+x(9)*h^2/2;
state_ini(4)=x(4);%+x(7)*h;
state_ini(5)=x(5);%+x(8)*h;
state_ini(6)=x(6);%+x(9)*h;
state_ini(7)=x(7);
state_ini(8)=x(8);
state_ini(9)=x(9);
% state_ini(10)=x(10);
% state_ini(11)=x(11);
% state_ini(12)=x(12);
% state_ini(13)=x(13);
% state_ini(14)=x(14);
