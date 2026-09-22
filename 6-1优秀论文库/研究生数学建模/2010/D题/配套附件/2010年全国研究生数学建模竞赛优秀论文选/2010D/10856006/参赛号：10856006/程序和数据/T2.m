%% 题二程序,x为横坐标向量，y为纵坐标，dy1为横坐标移动一次上转台电机应消除的余量，b1为中台的脉冲，c1为上台的脉冲
xb=0:1/300:600;
y2=30*exp(-xb/400).*sin((xb+25)/100)+130;

y2d=diff(y2)*90000;
dy2=zeros(1,180001);
for a=2:180001;
    dy2(a)=y2d(a-1);
end
dy2(1)=dy2(2);
clear y2d a

%% 砂轮选型
dy2d=zeros(1,180001);
for a=1:180001;
dy2d(a)=1/dy2(a);
end

B=zeros(1,60001);
for a=40000:100000;
    for b=140000:180001;
        [m,n]=min(abs(dy2d(a)-dy2(b)));
        x0=dy2d(a)/(dy2d(a)^2-1)*(y2(n)-y2(a)-1/dy2d(a)*xb(n)/300+dy2d(a)*xb(a));
        y0=dy2d(a)/(dy2d(a)^2-1)*(y2(n)-y2(a))-1/(dy2d(a)^2-1)*(xb(n)-xb(a));
        B(a-39999)=(xb(n)-x0)^2+(y2(n)-y0)^2;
    end
end
B2=sqrt(min(B));
clear a b x0 y0 dy2d

%% 计算上台,中台电机脉冲
b2=zeros(1,180001);
s=zeros(1,180001);
c2=zeros(1,180001);
ss=zeros(1,180001);

x1=y2(1);
x2=y2(2);
xx1=dy2(1);
xx2=dy2(2);

for a=2:180000;
    ss(a)=xx1-xx2;
    if abs(ss(a))<0.5/300;
        c2(a)=0;
        xx1=xx1;
        xx2=dy2(a+1);
        x1=x1;
    else 
        c2(a)=round(ss(a)*300);
        xx1=xx1-round(ss(a)*300)/300;
        xx2=dy2(a+1);
        x1=x1-round(ss(a)*300)/300*(xb(a)-250)/300;
    end
      s(a)=x1-x2;
   if abs(s(a))<0.5/300;
      b2(a)=0;
      x1=x1;
      x2=y2(a+1);
   else
      b2(a)=round(s(a)*300);
      x1=x1-round(s(a)*300)/300;
      x2=y2(a+1);
   end
end
clear s ss x1 x2 xx1 xx2 a

%% 计算曲线
yy2=zeros(1,180001);
yy2(1)=y2(1);
for a=2:180001;
    yy2(a)=yy2(a-1)-c2(a)/300*(xb(a)-250)/300-b2(a)/300;
end
clear a

%% 误差
y2cha=yy2-y2;
% y2chaz=sum(abs(y2cha));
% y2chaj=mean(abs(y2cha));
% y2cham=max(abs(y2cha));

%% 绘图
subplot(2,2,1)
plot(xb,y2,xb,yy2,'r')
subplot(2,2,2)
plot(xb,y2cha)
subplot(2,2,3)
plot(xb,b2)
subplot(2,2,4)
plot(xb,c2)
