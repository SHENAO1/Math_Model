%观测卫星运动微分方程
function dy=myfun_1(t,y)
G=3.986005e14;
dy=zeros(6,1);
dy(1)=y(4);
dy(2)=y(5);
dy(3)=y(6);
dy(4)=-G/norm([y(1);y(2);y(3)])^3*y(1);
dy(5)=-G/norm([y(1);y(2);y(3)])^3*y(2);
dy(6)=-G/norm([y(1);y(2);y(3)])^3*y(3);
