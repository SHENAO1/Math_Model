%生成模拟观测量
clear all
mdata_60=load('meadata_06_00.txt');
mdata_90=load('meadata_09_00.txt');
sati=load('satinfo.txt');
%mdata_60(:,1)与mdata_90(:,1)分别是6号与9号的测量时间（与第二问测量时间相同）
%生成各测量时刻目标物所在位置
zuobiao6=zeros(600,3);
zuobiao9=zeros(600,3);
i=0;
for t=mdata_60(1,1):0.2:170
    i=i+1;
zuobiao6(i,1)=-30*t^2+2000*t-1.13e6;
zuobiao6(i,2)=10*t^2+1700*t+6.21e6;
zuobiao6(i,3)=40*t^2+2600*t+1.16e6;
end
i=0;
for t=mdata_90(1,1):0.2:170
    i=i+1;
zuobiao9(i,1)=-30*t^2+2000*t-1.13e6;
zuobiao9(i,2)=10*t^2+1700*t+6.21e6;
zuobiao9(i,3)=40*t^2+2600*t+1.16e6;
end
%计算测量时刻卫星所在位置
[r1,posi_06]=ode45(@myfun_1,[0;mdata_60(:,1)],sati(7,:));
[r1,posi_09]=ode45(@myfun_1,[0;mdata_90(:,1)],sati(10,:));
posi_06=posi_06(2:end,:);
posi_09=posi_09(2:end,:);
%坐标系转换：先绕z轴旋转Ls角度，然后绕y轴旋转Bs角度，再平移(-R,0,0)
Ls_6=atan(posi_06(:,2)./posi_06(:,1))+pi;
Bs_6=atan(posi_06(:,3)./sqrt(posi_06(:,1).^2+posi_06(:,2).^2));
Ls_9=atan(posi_09(:,2)./posi_09(:,1));
Bs_9=atan(posi_09(:,3)./sqrt(posi_09(:,1).^2+posi_09(:,2).^2));
R06=sqrt(posi_06(:,1).^2+posi_06(:,2).^2+posi_06(:,3).^2);
R09=sqrt(posi_09(:,1).^2+posi_09(:,2).^2+posi_09(:,3).^2);
guance6=zeros(600,3);
guance9=zeros(600,3);
for i=1:600
guance6(i,:)=zuobiao6(i,:)*[cos(Ls_6(i)),-sin(Ls_6(i)),0;sin(Ls_6(i)),cos(Ls_6(i)),0;0,0,1]*[cos(Bs_6(i)),0,-sin(Bs_6(i));0,1,0;sin(Bs_6(i)),0,cos(Bs_6(i))]-[R06(i),0,0];
guance9(i,:)=zuobiao9(i,:)*[cos(Ls_9(i)),-sin(Ls_9(i)),0;sin(Ls_9(i)),cos(Ls_9(i)),0;0,0,1]*[cos(Bs_9(i)),0,-sin(Bs_9(i));0,1,0;sin(Bs_9(i)),0,cos(Bs_9(i))]-[R09(i),0,0];
end
alpha6=guance6(:,2)./guance6(:,1);
beta6=guance6(:,3)./guance6(:,1);
alpha9=guance9(:,2)./guance9(:,1);
beta9=guance9(:,3)./guance9(:,1);

%叠加系统误差
dalpha6=-3e-4;dbeta6=4e-4;dtheta6=2e-4;
dalpha9=4e-4;dbeta9=3e-4;dtheta9=-6e-4;
dab6=zeros(600,2);
dab9=zeros(600,2);
for i=1:600
dab6(i,:)=[alpha6(i),beta6(i)]*[cos(dtheta6),-sin(dtheta6);sin(dtheta6),cos(dtheta6)]+[dalpha6,dbeta6];
dab9(i,:)=[alpha9(i),beta9(i)]*[cos(dtheta9),-sin(dtheta9);sin(dtheta9),cos(dtheta9)]+[dalpha9,dbeta9];
end
%叠加随机噪声
zaosheng6=normrnd(0,2e-6,600,2);
dab6=dab6+zaosheng6;
zaosheng9=normrnd(0,2e-6,600,2);
dab9=dab9+zaosheng9;
save('yuanshi','zuobiao6','zuobiao9','zaosheng6','zaosheng9')
gdata_60=zeros(600,3);
gdata_90=zeros(600,3);
gdata_60(:,1)=mdata_60(:,1);
gdata_90(:,1)=mdata_90(:,1);
gdata_60(:,2:3)=dab6;
gdata_90(:,2:3)=dab9;
save('guance','gdata_60','gdata_90')