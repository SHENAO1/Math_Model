%% 问题4 磨损问题
B4=15;
xd=0:1/300:600;
[m4,n4]=size(xd);
y4=30*exp(-xd/400).*sin((xd+25)/100)+130;
y4d=diff(y4)*300;
dy4=zeros(1,n4);
for a=2:n4;
    dy4(a)=y4d(a-1);
end
dy4(1)=dy4(2);
clear y4d a m4

%% 将工件母线分段
% 求斜率为0的点
n=zeros(1,6);
[m,n(2)]=min(abs(dy4([1:60000])));
[m,n(5)]=min(abs(dy4([60000:160000])));
n(5)=n(5)+60000-1;
% 求其余分段点
[m,n(1)]=min(abs(abs(dy4([1:n(2)]))-0.012));
[m,n(3)]=min(abs(abs(dy4([n(2):n(5)]))-0.012));
n(3)=n(3)+n(2)-1;
[m,n(4)]=min(abs(abs(dy4([(n(3)+5000):n(5)]))-0.012));
n(4)=n(4)+n(3)-1;
[m,n(6)]=min(abs(abs(dy4([n(5):180001]))-0.012));
n(6)=n(6)+n(5)-1;
clear m
    
%% 在曲线的基础上修正模型，计算工作台电机脉冲,砂轮最大纵截面圆弧定点坐标（xs，ys），中台店家脉冲b4，上台电机脉冲c4
xs=zeros(1,180001);
ys=zeros(1,180001);
for a=1:n(1);
    xs(a)=xd(a)-1.5*dy4(a)/sqrt(1+dy4(a)^2)-6;
    ys(a)=y4(a)-500+sqrt((500-1.5)^2-36)+1.5/sqrt(1+dy4(a)^2);
end
for a=(n(1)+1):n(2);
    xs(a)=xd(a)-500*dy4(a)/sqrt(1+dy4(a)^2);
    ys(a)=y4(a)-500+500/sqrt(1+dy4(a)^2);
end
for a=(n(2)+1):n(3);
    xs(a)=xd(a)-500*dy4(a)/sqrt(1+dy4(a)^2);
    ys(a)=y4(a)-500+500/sqrt(1+dy4(a)^2);
end
for a=(n(3)+1):n(4);
    xs(a)=xd(a)-1.5*dy4(a)/sqrt(1+dy4(a)^2)+6;
    ys(a)=y4(a)-500+sqrt((500-1.5)^2-36)+1.5/sqrt(1+dy4(a)^2);
end
for a=(n(4)+1):n(5);
    xs(a)=xd(a)-500*dy4(a)/sqrt(1+dy4(a)^2);
    ys(a)=y4(a)-500+500/sqrt(1+dy4(a)^2);
end
for a=(n(5)+1):n(6);
    xs(a)=xd(a)-500*dy4(a)/sqrt(1+dy4(a)^2);
    ys(a)=y4(a)-500+500/sqrt(1+dy4(a)^2);
end
for a=(n(6)+1):180001;
    xs(a)=xd(a)-1.5*dy4(a)/sqrt(1+dy4(a)^2)-6;
    ys(a)=y4(a)-500+sqrt((500-1.5)^2-36)+1.5/sqrt(1+dy4(a)^2);
end

b4=zeros(1,180001);
s=zeros(1,180001);
c4=zeros(1,180001);
ss=zeros(1,180001);

x1=ys(1);
x2=ys(2);

for a=2:180000;
      s(a)=x1-x2;
   if abs(s(a))<0.5/300;
      b4(a)=0;
      x1=x1;
      x2=y4(a+1);
   else
      b4(a)=round(s(a)*300);
      x1=x1-round(s(a)*300)/300;
      x2=y4(a+1);
   end
end
clear a x1 x2 s ss

%% 计算加工曲线
yy4=zeros(1,180001);
yy4(1)=y4(1);
for a=2:180001;
    yy4(a)=yy4(a-1)-b4(a)/300;
end
clear a

%% 计算砂轮最大纵截面顶点曲线
plot(xs,ys)

%% 误差
y4cha=yy4-y4;
% y4chaz=sum(abs(y4cha));
% y4chaj=mean(abs(y4cha));
% y4cham=max(abs(y4cha));

%% 绘图
subplot(2,2,1)
plot(xd,y4,xd,yy4,'r')
subplot(2,2,2)
plot(xd,y4cha)
subplot(2,2,3)
plot(xd,b4)
subplot(2,2,4)
plot(xd,c4)
