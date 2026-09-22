%% 问题3 磨损点移动问题
B3=15;
xc=0:1/300:600;
[m3,n3]=size(xc);
y3=-7*(600-xc).^2/18000+0.45*(600-xc);
y3d=diff(y3)*90000;
dy3=zeros(1,n3);
for a=2:n3;
    dy3(a)=y3d(a-1);
end
dy3(1)=dy3(2);
clear y3d a m3

%% 计算上台,中台电机脉冲
b3=zeros(1,n3);
s=zeros(1,n3);
c3=zeros(1,n3);
ss=zeros(1,n3);

x1=y3(1);
x2=y3(2);
xx1=dy3(1);
xx2=dy3(2);

for a=2:(n3-1);
    ss(a)=xx1-xx2;
    if abs(ss(a))<0.5/300;
        c3(a)=0;
        xx1=xx1;
        xx2=dy3(a+1);
        x1=x1;
    else 
        c3(a)=round(ss(a)*300);
        xx1=xx1-round(ss(a)*300)/300;
        xx2=dy3(a+1);
        x1=x1-round(ss(a)*300)/300*(xc(a)-250)/300;
    end
      s(a)=x1-x2;
   if abs(s(a))<0.5/300;
      b3(a)=0;
      x1=x1;
      x2=y3(a+1);
   else
      b3(a)=round(s(a)*300);
      x1=x1-round(s(a)*300)/300;
      x2=y3(a+1);
   end
end
clear s ss x1 x2 xx1 xx2 a

%% 计算曲线
yy3=zeros(1,n3);
yy3(1)=y3(1);
for a=2:n3;
    yy3(a)=yy3(a-1)-c3(a)/300*(xc(a)-250)/300-b3(a)/300;
end
clear a n3

%% 计算磨削点位置
m3=zeros(1,180001);
m3(1)=-7.5;
k=0;
for a=2:180001;
    if k==40
        k=0;
        m3(a)=m3(a-1)+1/300;
    else
        m3(a)=m3(a-1);
    end
   k=k+1;
end
clear a

%% 误差
y3cha=yy3-y3;
% y3chaz=sum(abs(y3cha));
% y3chaj=mean(abs(y3cha));
% y3cham=max(abs(y3cha));

%% 绘图
subplot(2,2,1)
plot(xc,y3,xc,yy3,'r')
subplot(2,2,2)
plot(xc,y3cha)
subplot(2,2,3)
plot(xc,b3)
subplot(2,2,4)
plot(xc,c3)
