%第二问搜索初值的遗传算法调用的函数
function y=myfun_3(drx)
global time posi00_1
[t r_1]=ode45(@myfun_2,time,drx);
cancha=r_1(:,1:3)-posi00_1(1:end,:);
y=sum(sum(cancha.^2,2));