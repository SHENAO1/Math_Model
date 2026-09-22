%利用LS解目标位置的程序%
close all;
clear all;clc;
format short;
%%%定步长rugga-kutta方法 计算卫星9的位置 6y(:,i)的物理意义-->[x vx y vy z vz]';
h=0.2;
tmin=0;
tmax=255.4;
N=1+(tmax-tmin)/h;
y9=zeros(6,N);
% x=zeros(1,N);
y9(:,1)=[ 2043922.166765 ; -5379.544693; 8186504.631471;   -407.095342 ;  4343461.714791 ;     3516.052656];%%初值  -1732113.220573    9092044.771852    1732113.220573      -4453.807606      -1566.513180       4453.807606
% y6(:,1)= [-1732113.220573 ;-4453.807606;  9092044.771852;    -1566.513180 ;  1732113.220573 ;     4453.807606]; %%%% -1732113.220573    9092044.771852    1732113.220573      -4453.807606      -1566.513180       4453.80760
% x(1)=0;
for i=2:N
%     x(i)=x(i-1)+h;    
    k19=vdp(y9(:,i-1));
    k29=vdp(y9(:,i-1)+h*k19/2);
    k39=vdp(y9(:,i-1)+h*k29/2);
    k49=vdp(y9(:,i-1)+h*k39);
    y9(:,i)=y9(:,i-1)+h*(k19+2*k29+2*k39+k49)/6; %按照龙格库塔方法进行数值求解
end
%%（时间范围是0：0.2：255.4s）;
T=0:0.2:255.4;
%%%%%%关于y6和y9 第t+1列存储了t时刻的状态向量
Y9=y9;
y9=y9(1:2:5,:);%%%只保留卫星的位置信息


%--------卫星9量测偏差---------------------%
dalfa9=0.000838309110536;
dbeta9=0.000515880618458;
%%%%%%考虑70.2:0.2:255.4之间的各时刻值%%%%%%%%%%
t0=49;
M=(255.4-t0)/h+1;
state_zero=[];
options=optimset('MaxIter',4000)%'MaxFunEvals',20000,
%%%计算49时刻的初始状态(49:0.2:49.4)

state_zero=[];%%%%%%%%%%%存储定位结果
Mar_cond=[];%定位矩阵条件数
for i=246:1:1274%%%%%%%（49s-255s）
t0=(i-1)*0.2;
alfa0=alfafun(t0,dalfa9);
beta0=betafun(t0,dbeta9);
x09=y9(1,i);%%%%%%%%%对应于t时刻的坐标
y09=y9(2,i);
z09=y9(3,i);
r09=norm(y9(:,i));
thou09=norm(y9(1:2,i));
A=[x09/r09 -y09/thou09 -x09*z09/r09/thou09; y09/r09 x09/thou09 -y09*z09/r09/thou09;z09/r09 0 thou09/r09];
fff1=[1 0 0 0 0 0 -A(1,:)*[1 alfa0 beta0]' 0 0;...
      0 1 0 0 0 0 -A(2,:)*[1 alfa0 beta0]' 0 0;...
      0 0 1 0 0 0 -A(3,:)*[1 alfa0 beta0]' 0 0];
bbb1=[x09 y09 z09]';
alfa0=alfafun(t0+h,dalfa9);
beta0=betafun(t0+h,dbeta9);
x09=y9(1,1+i);%%%%%%%%%对应于t时刻的坐标
y09=y9(2,1+i);
z09=y9(3,1+i);
r09=norm(y9(:,1+i));
thou09=norm(y9(1:2,1+i));
A=[x09/r09 -y09/thou09 -x09*z09/r09/thou09; y09/r09 x09/thou09 -y09*z09/r09/thou09;z09/r09 0 thou09/r09];
fff2=[1 0 0 h 0 0 0 -A(1,:)*[1 alfa0 beta0]'  0;...
      0 1 0 0 h 0 0 -A(2,:)*[1 alfa0 beta0]'  0;...
      0 0 1 0 0 h 0 -A(3,:)*[1 alfa0 beta0]'  0];
bbb2=[x09 y09 z09]';

% t0=246+2*h;
alfa0=alfafun(t0+2*h,dalfa9);
beta0=betafun(t0+2*h,dbeta9);
x09=y9(1,2+i);%%%%%%%%%对应于t时刻的坐标
y09=y9(2,2+i);
z09=y9(3,2+i);
r09=norm(y9(:,2+i));
thou09=norm(y9(1:2,2+i));
A=[x09/r09 -y09/thou09 -x09*z09/r09/thou09; y09/r09 x09/thou09 -y09*z09/r09/thou09;z09/r09 0 thou09/r09];
fff3=[1 0 0 2*h 0 0 0 0 -A(1,:)*[1 alfa0 beta0]'  ;...
      0 1 0 0 2*h 0 0 0 -A(2,:)*[1 alfa0 beta0]'  ;...
      0 0 1 0 0 2*h 0 0 -A(3,:)*[1 alfa0 beta0]'  ];
bbb3=[x09 y09 z09]';
fff=[fff1;fff2;fff3];
bbb=[bbb1;bbb2;bbb3];
%------------------------对定位矩阵fff的病态特性进行分析---------------------%
Mar_cond=[Mar_cond [cond(fff,1) cond(fff) cond(fff,inf)]'];
%-------------------------------------------------------------------------%
 
% state_ini=inv(fff'*fff)*fff'*bbb;
S=cat(2,-bbb,fff);
[u,v,w]=svd(S);
state_ini=w(2:end,end)/w(1,end);
state_zero=[state_zero state_ini];
end
 
%%%
% options=optimset('MaxIter',4000);%'MaxFunEvals',20000,
% for i=1:M-2
%     tempy9=y9(:,1+t0/h:3+t0/h);
%     tempt=[t0+(i-1)*0.2 t0+i*0.2 t0+(i+1)*0.2];
%     tempalfa=alfafun(tempt,dalfa9);
%     tempbeta=betafun(tempt,dbeta9);
%     
% %    F=fun_equ(x,tempy9,tempt,tempalfa,tempbeta);
%     x=fsolve(@(x)fun_equ(x,tempy9,h,tempalfa,tempbeta),state_ini,options);%h为步长
%     state_zero=[state_zero x(1:7)];
%     state_ini=inijinsi(x,h);%x;%
% end
pos_zero=state_zero(1:3,:);
vel_zero=state_zero(4:6,:);
xs_zero=state_zero(7,:);%%%%%%%%%%对比计算用
%%%
%----------50s到255s间每隔0.2s给出的1号目标位置和速度-------------%
figure;
plot3(pos_zero(1,:),pos_zero(2,:),pos_zero(3,:));title('单星1号目标位置');
figure;
plot3(vel_zero(1,:),vel_zero(2,:),vel_zero(3,:));title('单星1号目标速度');
l=length(pos_zero);
figure;
subplot(3,1,1);plot(1:l,pos_zero(1,:));title('t-x');
subplot(3,1,2);plot(1:l,pos_zero(2,:));title('t-y');
subplot(3,1,3);plot(1:l,pos_zero(3,:));title('t-z');
figure;
subplot(3,1,1);plot(1:l,vel_zero(1,:));title('t-x');
subplot(3,1,2);plot(1:l,vel_zero(2,:));title('t-y');
subplot(3,1,3);plot(1:l,vel_zero(3,:));title('t-z');
%-----------49s-171s数据采样（间隔为1s）------------------------------------%

t0=49;
comy9=Y9(:,1+t0/h:5:856);%%%%%%%%%%卫星状态
compos=pos_zero(:,1:5:611);
comvel=vel_zero(:,1:5:611);
comxs=xs_zero(1:5:611);
[comalfa,combeta]=pos2meas(compos,comxs,comy9);%%%%%%%%%%%由解算后的坐标反推量测
mt=[49:1:49+122];
malfa=alfafun(mt,dalfa9);
mbeta=betafun(mt,dbeta9);
%------------
figure;
subplot(2,1,1);plot(malfa);hold on;plot(comalfa,'r-');hold off
subplot(2,1,2);plot(mbeta);hold on;plot(combeta,'r-');hold off
title('SSSSSSSSSSSS')
%-------------------------------------------------------------------------%
l=length(comy9);
figure;
plot3(compos(1,:),compos(2,:),compos(3,:));title('单星1号目标位置');
figure;
plot3(comvel(1,:),comvel(2,:),comvel(3,:));title('单星1号目标速度');
l=length(compos);
figure;
subplot(3,1,1);plot(t0:t0+l-1,compos(1,:));title('t(49-171)-x');
subplot(3,1,2);plot(t0:t0+l-1,compos(2,:));title('t(49-171)-y');
subplot(3,1,3);plot(t0:t0+l-1,compos(3,:));title('t(49-171)-z');
figure;
subplot(3,1,1);plot(t0:t0+l-1,comvel(1,:));title('t(49-171)-vx');
subplot(3,1,2);plot(t0:t0+l-1,comvel(2,:));title('t(49-171)-vy');
subplot(3,1,3);plot(t0:t0+l-1,comvel(3,:));title('t(49-171)-vz');
%-------------------------------------------------------------------------%
hh=1;
tmin=0;
tmax=171;
t0=49;
NN=1+(tmax-tmin)/hh;
y9=zeros(6,NN);
y9(:,t0+1:end)=comy9;
pos1=zeros(3,NN);%%%%LS估计
pos1(:,t0+1:end)=compos;%%%%%（compos的第一个向量表示第t0（也就是49s）时刻的状态）
%----------------------利用定位后的数据pos1来计算个时刻的状态估计
[xx,yy,zz]=chafen(pos1);  %xx:x方向的状态向量（位置 速度 加速度）yy zz同此
%--------------------------------------------------------------------------
%----------------------x方向-------------%
xigma0=0;
xigma1=0;
xigma2=0;

xigma0k1=0;
xigma1k1=0;
xigma2k1=0;

xigma3=0;
xigma4=0;
for t=50:170
    [tempv ,tempk]=kxyz(xx,yy,zz,t);
    xigma0=xigma0+tempv(1)*1;
    xigma1=xigma1+tempv(1)*t;
    xigma2=xigma2+tempv(1)*t^2;
    xigma3=xigma3+tempv(1)*t^3;
    xigma4=xigma4+tempv(1)*t^4;
%     tempk=kxyz(xx,yy,zz,t);
    xigma0k1=xigma0k1+tempk(1);
    xigma1k1=xigma1k1+tempk(1)*t;
    xigma2k1=xigma2k1+tempk(1)*t^2;
end
    Ax=[xigma0 xigma1 xigma2;xigma1 xigma2 xigma3;xigma2 xigma3 xigma4];
    bx=[xigma0k1 xigma1k1 xigma2k1]';
    xcoff=inv(Ax)*bx;
    %----------------------y方向-------------%
    
xigma0=0;
xigma1=0;
xigma2=0;

xigma0k2=0;
xigma1k2=0;
xigma2k2=0;
xigma3=0;
xigma4=0;
for t=50:170
     [tempv ,tempk]=kxyz(xx,yy,zz,t);
    xigma0=xigma0+tempv(2)*1;
    xigma1=xigma1+tempv(2)*t;
    xigma2=xigma2+tempv(2)*t^2;
    xigma3=xigma3+tempv(2)*t^3;
    xigma4=xigma4+tempv(2)*t^4;
%     tempk=kxyz(xx,yy,zz,t);
    xigma0k2=xigma0k2+tempk(2);
    xigma1k2=xigma1k2+tempk(2)*t;
    xigma2k2=xigma2k2+tempk(2)*t^2;
end
    Ay=[xigma0 xigma1 xigma2;xigma1 xigma2 xigma3;xigma2 xigma3 xigma4];
    by=[xigma0k2 xigma1k2 xigma2k2]';
    ycoff=inv(Ay)*by;
    
%----------------------z方向-------------%
xigma0=0;
xigma1=0;
xigma2=0;

xigma0k3=0;
xigma1k3=0;
xigma2k3=0;

xigma3=0;
xigma4=0;
for t=50:170
 [tempv ,tempk]=kxyz(xx,yy,zz,t);
    xigma0=xigma0+tempv(3)*1;
    xigma1=xigma1+tempv(3)*t;
    xigma2=xigma2+tempv(3)*t^2;
    xigma3=xigma3+tempv(3)*t^3;
    xigma4=xigma4+tempv(3)*t^4;
%     tempk=kxyz(xx,yy,zz,t);
    xigma0k3=xigma0k3+tempk(3);
    xigma1k3=xigma1k3+tempk(3)*t;
    xigma2k3=xigma2k3+tempk(3)*t^2;
end
    Az=[xigma0 xigma1 xigma2;xigma1 xigma2 xigma3;xigma2 xigma3 xigma4];
    bz=[xigma0k3 xigma1k3 xigma2k3]';
    zcoff=inv(Az)*bz;
%--------------反解微分方程------------------------------------------%
y_ini=[compos(1,1) comvel(1,1) compos(2,1) comvel(2,1) compos(3,1) comvel(3,1)]';%%%第49s的状态
y_res=zeros(6,171);
y_res(:,49)=y_ini;
F=[1 0 0 0 0 0 ;xcoff(1)+xcoff(2)*(t)+xcoff(3)*(t)^2 -1 0 0 0 0; 0 0 1 0 0 0;0 0 ycoff(1)+ycoff(2)*(t)+ycoff(3)*(t)^2 -1 0 0;0 0 0 0 1 0;0 0 0 0 zcoff(1)+zcoff(2)*(t)+zcoff(3)*(t)^2 -1];

for t=50:170
    
    k1=vdp2(t-1,y_res(:,t-1),xcoff,ycoff,zcoff);
    k2=vdp2(t-1+hh/2,y_res(:,t-1)+hh*k1/2,xcoff,ycoff,zcoff);
    k3=vdp2(t-1+hh/2,y_res(:,t-1)+hh*k2/2,xcoff,ycoff,zcoff);
    k4=vdp2(t-1+hh,y_res(:,t-1)+hh*k3,xcoff,ycoff,zcoff);
    y_res(:,t)=y_res(:,t-1)+hh*(k1+2*k2+2*k3+k4)/6; %按照龙格库塔方法进行数值求解
 end
figure;
plot3(y_res(1,50:170),y_res(3,50:170),y_res(5,50:170))%%%%%%%%%%%%%%%y_res的第t列既是t时刻的状态向量
title('龙格库塔法 解算1号目标位置')


figure;
subplot(3,1,1);plot(50:170,y_res(1,50:170));title('RG-t(50-170)-x');
subplot(3,1,2);plot(50:170,y_res(3,50:170));title('RG-t(50-170)-y');
subplot(3,1,3);plot(50:170,y_res(5,50:170));title('RG-t(50-170)-z');
figure;
subplot(3,1,1);plot(50:170,y_res(2,50:170));title('RG-t(50-170)-vx');
subplot(3,1,2);plot(50:170,y_res(4,50:170));title('RG-t(50-170)-vy');
subplot(3,1,3);plot(50:170,y_res(6,50:170));title('RG-t(50-170)-vz');

%------------------%------------位置估计残差----------------%
res1_pos=compos(:,2:122);
res2_pos=y_res(1:2:5,50:170);
for i=1:length(res2_pos)
    error1_pos(:,i)=res1_pos(:,i)-res2_pos(:,i);
end
disp('t=50:10:170');
error1_pos(:,1:10:121)
%--------------------------------------%
%------------速度估计残差----------------%
res3_vel=[xx(2,51:end);yy(2,51:end);zz(2,51:end)];
res4_vel=y_res(2:2:6,50:170);
for i=1:length(res4_vel)
    error2_vel(:,i)=res3_vel(:,i)-res4_vel(:,i);
end
disp('t=50:10:170');
error2_vel(:,1:10:121)
vel_error=error2_vel(:,1:10:121);
pos_error=error1_pos(:,1:10:121);
disp('x方向位置残差：');std(pos_error(1,:),1)
disp('y方向位置残差：');std(pos_error(2,:),1)
disp('z方向位置残差：');std(pos_error(3,:),1)
disp('x方向速度残差：');std(vel_error(1,:),1)
disp('y方向速度残差：');std(vel_error(2,:),1)
disp('z方向速度残差：');std(vel_error(3,:),1)










   




