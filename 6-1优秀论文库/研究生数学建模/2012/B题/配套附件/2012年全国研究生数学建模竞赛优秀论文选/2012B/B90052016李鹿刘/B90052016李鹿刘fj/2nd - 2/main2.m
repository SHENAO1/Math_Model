close all;
clear all;clc;
format long;
%%%定步长rugga-kutta方法 计算卫星6和9的位置 6y(:,i)的物理意义-->[x vx y vy z vz]';
h=1;
tmin=0;
tmax=170;
N=1+(tmax-tmin)/h;
y6=zeros(6,N);
y9=zeros(6,N);
x=zeros(1,N);
y9(:,1)=[ 2043922.166765 ; -5379.544693; 8186504.631471;   -407.095342 ;  4343461.714791 ;     3516.052656];%%初值  -1732113.220573    9092044.771852    1732113.220573      -4453.807606      -1566.513180       4453.807606
y6(:,1)= [-1732113.220573 ;-4453.807606;  9092044.771852;    -1566.513180 ;  1732113.220573 ;     4453.807606]; %%%% -1732113.220573    9092044.771852    1732113.220573      -4453.807606      -1566.513180       4453.80760
x(1)=0;
for i=2:N
    x(i)=x(i-1)+h;
    k16=vdp(y6(:,i-1));
    k26=vdp(y6(:,i-1)+h*k16/2);
    k36=vdp(y6(:,i-1)+h*k26/2);
    k46=vdp(y6(:,i-1)+h*k36);
    y6(:,i)=y6(:,i-1)+h*(k16+2*k26+2*k36+k46)/6; %按照龙格库塔方法进行数值求解
    
    k19=vdp(y9(:,i-1));
    k29=vdp(y9(:,i-1)+h*k19/2);
    k39=vdp(y9(:,i-1)+h*k29/2);
    k49=vdp(y9(:,i-1)+h*k39);
    y9(:,i)=y9(:,i-1)+h*(k19+2*k29+2*k39+k49)/6; %按照龙格库塔方法进行数值求解
   
end
%%%卫星轨迹图
figure;
plot3(y6(1,1:end),y6(3,1:end),y6(5,1:end));
hold on;
plot3(y9(1,1:end),y9(3,1:end),y9(5,1:end),'r');
hold off
title('卫星轨迹');
%%%%%%关于y6和y9 第t+1列存储了t时刻的状态向量
y6=y6(1:2:5,:);
y9=y9(1:2:5,:);%%%只保留卫星的位置信息

%---------交叉定位----------------%
pos1=zeros(3,N);%%%%LS估计
pos2=zeros(3,N);%%TLS估计
ran=[];
t=50;
for t=49:171
[tempp1,tempp2,temp]=crosslocal(y6,y9,t);
pos1(:,t+1)=tempp1;
pos2(:,t+1)=tempp2;
ran=[ran temp];
end
figure;
plot3(pos1(1,51:end),pos1(2,51:end),pos1(3,51:end),'^');
hold on;
plot3(pos2(1,51:end),pos2(2,51:end),pos2(3,51:end),'ro');
hold off
title('0号目标估计')

%%%%           利用定位后的数据pos1来计算个时刻的状态估计
[xx,yy,zz]=chafen(pos1);  %xx:x方向的状态向量（位置 速度 加速度）yy zz同此

%-------------3阶级数近似----------%

M3=[];
b3=[];
for t=50:170
    [tempm,tempb]=cofffun3(xx,yy,zz,t);
    M3=[M3;tempm];
    b3=[b3;tempb];
end
% tempM3=M3(1:10:121,:);
% tempb3=b3(1:10:121)；
tempM3=M3;
tempb3=b3;
x3ini=inv(tempM3'*tempM3)*tempM3'*tempb3;%%%%%%%LS 不好用
%----------------------x方向-------------%
xigma0=0;
xigma1=0;
xigma2=0;


xigma0k1=0;
xigma1k1=0;



for t=50:170
    [tempv ,tempk]=kxyz(xx,yy,zz,t);
    xigma0=xigma0+tempv(1)*1;
    xigma1=xigma1+tempv(1)*t;
    xigma2=xigma2+tempv(1)*t^2;

%     tempk=kxyz(xx,yy,zz,t);
    xigma0k1=xigma0k1+tempk(1);
    xigma1k1=xigma1k1+tempk(1)*t;

end
    Ax=[xigma0 xigma1;xigma1 xigma2];
    bx=[xigma0k1 xigma1k1]';
    xcoff=inv(Ax)*bx;
    %----------------------y方向-------------%
    
xigma0=0;
xigma1=0;
xigma2=0;

xigma0k2=0;
xigma1k2=0;

for t=50:170
     [tempv ,tempk]=kxyz(xx,yy,zz,t);
    xigma0=xigma0+tempv(2)*1;
    xigma1=xigma1+tempv(2)*t;
    xigma2=xigma2+tempv(2)*t^2;

%     tempk=kxyz(xx,yy,zz,t);
    xigma0k2=xigma0k2+tempk(2);
    xigma1k2=xigma1k2+tempk(2)*t;

end
    Ay=[xigma0 xigma1;xigma1 xigma2];
    by=[xigma0k2 xigma1k2]';
    ycoff=inv(Ay)*by;
    
%----------------------z方向-------------%
xigma0=0;
xigma1=0;
xigma2=0;

xigma0k3=0;
xigma1k3=0;

for t=50:170
 [tempv ,tempk]=kxyz(xx,yy,zz,t);
    xigma0=xigma0+tempv(3)*1;
    xigma1=xigma1+tempv(3)*t;
    xigma2=xigma2+tempv(3)*t^2;

%     tempk=kxyz(xx,yy,zz,t);
    xigma0k3=xigma0k3+tempk(3);
    xigma1k3=xigma1k3+tempk(3)*t;

end
    Az=[xigma0 xigma1 ;xigma1 xigma2 ];
    bz=[xigma0k3 xigma1k3]';
    zcoff=inv(Az)*bz;

%-------------反解微分方程--------%
for t=48:50
    [tempp1,tempp2,temp]=crosslocal(y6,y9,t);
    tpos1(:,t+1)=tempp1;
end
vini=(tpos1(:,51)-tpos1(:,49))/(2);



y_ini=[tpos1(1,49) vini(1) tpos1(2,49) vini(2) tpos1(3,49) vini(3)]';
y_res=zeros(6,171);
y_res(:,49)=y_ini;
% F=funF(xcoff,ycoff,zcoff,t);
hh=1;%步长

for t=50:170
    
    k1=vdp22(t-1,y_res(:,t-1),xcoff,ycoff,zcoff);
    k2=vdp22(t-1+hh/2,y_res(:,t-1)+hh*k1/2,xcoff,ycoff,zcoff);
    k3=vdp22(t-1+hh/2,y_res(:,t-1)+hh*k2/2,xcoff,ycoff,zcoff);
    k4=vdp22(t-1+hh,y_res(:,t-1)+hh*k3,xcoff,ycoff,zcoff);
    y_res(:,t)=y_res(:,t-1)+hh*(k1+2*k2+2*k3+k4)/6; %按照龙格库塔方法进行数值求解
end
figure;
plot3(y_res(1,50:170),y_res(3,50:170),y_res(5,50:170))
title('龙格库塔法 解算0号目标位置')
%------------位置估计残差----------------%
res1=pos1(:,51:end);
res2=y_res(1:2:5,50:170);
for i=1:length(res2)
    error1(:,i)=res1(:,i)-res2(:,i);
end
disp('t=50:10:170');
error1(:,1:10:121)
%--------------------------------------%
%------------速度估计残差----------------%
res3=[xx(2,51:end);yy(2,51:end);zz(2,51:end)];
res4=y_res(2:2:6,50:170);
for i=1:length(res4)
    error2(:,i)=res3(:,i)-res4(:,i);
end
disp('t=50:10:170');
error2(:,1:10:121)

vel_error=error2(:,1:10:121);
pos_error=error1(:,1:10:121);
disp('x方向位置残差：');std(pos_error(1,:),1)
disp('y方向位置残差：');std(pos_error(2,:),1)
disp('z方向位置残差：');std(pos_error(3,:),1)
disp('x方向速度残差：');std(vel_error(1,:),1)
disp('y方向速度残差：');std(vel_error(2,:),1)
disp('z方向速度残差：');std(vel_error(3,:),1)

% %---------差分得到目标的运动状态----------%
 figure;
 subplot(3,1,1);plot(50:170,xx(1,51:171));title('t-x')%t-x
 subplot(3,1,2);plot(50:170,yy(1,51:171));title('t-y')%t-y
 subplot(3,1,3);plot(50:170,zz(1,51:171));title('t-z')%t-z
 
 figure;
 subplot(3,1,1);plot(50:170,xx(2,51:171));title('t-vx')%t-vx
 subplot(3,1,2);plot(50:170,yy(2,51:171));title('t-vy')%t-vy
 subplot(3,1,3);plot(50:170,zz(2,51:171));title('t-vz')%t-vz


%--------解微分得到的目标的运动状态----------%
figure;
subplot(3,1,1);plot(50:170,y_res(1,50:170));title('t-x')%t-x
subplot(3,1,2);plot(50:170,y_res(3,50:170));title('t-y')%t-y
subplot(3,1,3);plot(50:170,y_res(5,50:170));title('t-z')%t-z

figure;
subplot(3,1,1);plot(50:170,y_res(2,50:170));title('t-vx')%t-vx
subplot(3,1,2);plot(50:170,y_res(4,50:170));title('t-vy')%t-vy
subplot(3,1,3);plot(50:170,y_res(6,50:170));title('t-vz')%t-vz




