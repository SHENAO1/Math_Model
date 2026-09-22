
%对齐时间选取两个卫星测量时间的中间时间
global time
time=(mdata_60(:,1)+mdata_90(:,1))/2;
%龙格库塔法求卫星位置
[r1,posi_09]=ode45(@myfun_1,[0;time],sati(10,:));
[r1,posi_06]=ode45(@myfun_1,[0;time],sati(7,:));
posi_09=posi_09(2:end,:);
posi_06=posi_06(2:end,:);
%三次样条插值处理meadata_06_00和meadata_09_00
global mdata0_60 mdata0_90 Bs_9 Ls_9 Bs_6 Ls_6 R06 R09
mdata0_60=zeros(600,2);
mdata0_90=zeros(600,2);
mdata0_60(:,1)=spline(mdata_60(:,1),mdata_60(:,2),time);
mdata0_60(:,2)=spline(mdata_60(:,1),mdata_60(:,3),time);
mdata0_90(:,1)=spline(mdata_90(:,1),mdata_90(:,2),time);
mdata0_90(:,2)=spline(mdata_90(:,1),mdata_90(:,3),time);
%交汇定位
global posi00_1;
posi00_1=zeros(600,3);
%cancha=zeros(600,4);
%坐标系转换：先绕z轴旋转Ls角度，然后绕y轴旋转Bs角度，再平移(-R,0,0)
Ls_6=atan(posi_06(:,2)./posi_06(:,1))+pi;
Bs_6=atan(posi_06(:,3)./sqrt(posi_06(:,1).^2+posi_06(:,2).^2));
Ls_9=atan(posi_09(:,2)./posi_09(:,1));
Bs_9=atan(posi_09(:,3)./sqrt(posi_09(:,1).^2+posi_09(:,2).^2));
R06=sqrt(posi_06(:,1).^2+posi_06(:,2).^2+posi_06(:,3).^2);
R09=sqrt(posi_09(:,1).^2+posi_09(:,2).^2+posi_09(:,3).^2);

for i=1:600
A=[(mdata0_90(i,1)*cos(Bs_9(i))*cos(Ls_9(i))+sin(Ls_9(i))),(mdata0_90(i,1)*cos(Bs_9(i))*sin(Ls_9(i)) - cos(Ls_9(i))),mdata0_90(i,1)*sin(Bs_9(i))
(mdata0_90(i,2)*cos(Bs_9(i))*cos(Ls_9(i))+cos(Ls_9(i))*sin(Bs_9(i))),(mdata0_90(i,2)*cos(Bs_9(i))*sin(Ls_9(i))+sin(Bs_9(i))*sin(Ls_9(i))),(mdata0_90(i,2)*sin(Bs_9(i))- cos(Bs_9(i)))
 (mdata0_60(i,1)*cos(Bs_6(i))*cos(Ls_6(i))+sin(Ls_6(i))), (mdata0_60(i,1)*cos(Bs_6(i))*sin(Ls_6(i)) - cos(Ls_6(i))),mdata0_60(i,1)*sin(Bs_6(i))
(mdata0_60(i,2)*cos(Bs_6(i))*cos(Ls_6(i))+cos(Ls_6(i))*sin(Bs_6(i))),(mdata0_60(i,2)*cos(Bs_6(i))*sin(Ls_6(i))+sin(Bs_6(i))*sin(Ls_6(i))),(mdata0_60(i,2)*sin(Bs_6(i))- cos(Bs_6(i)))];
B=[mdata0_90(i,1)*R09(i); mdata0_90(i,2)*R09(i);mdata0_60(i,1)*R06(i); mdata0_60(i,2)*R06(i)];
%求Ax=B的最小二乘解为定位位置
posi00_1(i,:)=(A\B)';
%cancha(i,:)=(A*posi00_1(i,:)'-B)';
end
%从50.1783s间隔10秒的定位位置
answer2_1=posi00_1(1:50:600);