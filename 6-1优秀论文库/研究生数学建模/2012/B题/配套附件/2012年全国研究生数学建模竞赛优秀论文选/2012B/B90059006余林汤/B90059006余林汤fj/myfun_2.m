%飞行器运动方程
function dy=myfun_2(t,y)
%c1,c2为与m，v有关的参数
global c1 c2;
G=3.986005e14;
dy=zeros(6,1);
dy(1)=y(4);
dy(2)=y(5);
dy(3)=y(6);
dy(4)=-G/norm([y(1);y(2);y(3)])^3*y(1)+y(4)/norm([y(4);y(5);y(6)])/(c1*t+c2);
dy(5)=-G/norm([y(1);y(2);y(3)])^3*y(2)+y(5)/norm([y(4);y(5);y(6)])/(c1*t+c2);
dy(6)=-G/norm([y(1);y(2);y(3)])^3*y(3)+y(6)/norm([y(4);y(5);y(6)])/(c1*t+c2);
