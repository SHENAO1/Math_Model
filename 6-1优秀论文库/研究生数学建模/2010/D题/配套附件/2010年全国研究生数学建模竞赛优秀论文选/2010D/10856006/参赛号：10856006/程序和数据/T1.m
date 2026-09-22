%% 题一程序,x为横坐标向量，y为纵坐标，dy1为横坐标移动一次上转台电机应消除的余量，b1为中台的脉冲，c1为上台的脉冲
xa=0:1/300:600;
y1=-7*(600-xa).^2/18000+0.45*(600-xa);

y1d=diff(y1)*90000;
dy1=zeros(1,180001);
for a=2:180001;
    dy1(a)=y1d(a-1);
end
dy1(1)=dy1(2);
clear y1d a

%% 计算上台,中台电机脉冲
b1=zeros(1,180001);
s=zeros(1,180001);
c1=zeros(1,180001);
ss=zeros(1,180001);

x1=y1(1);
x2=y1(2);
xx1=dy1(1);
xx2=dy1(2);

for a=2:180000;
    ss(a)=xx1-xx2;
    if abs(ss(a))<0.5/300;
        c1(a)=0;
        xx1=xx1;
        xx2=dy1(a+1);
        x1=x1;
    else 
        c1(a)=round(ss(a)*300);
        xx1=xx1-round(ss(a)*300)/300;
        xx2=dy1(a+1);
        x1=x1-round(ss(a)*300)/300*(xa(a)-250)/300;
    end
      s(a)=x1-x2;
   if abs(s(a))<0.5/300;
      b1(a)=0;
      x1=x1;
      x2=y1(a+1);
   else
      b1(a)=round(s(a)*300);
      x1=x1-round(s(a)*300)/300;
      x2=y1(a+1);
   end
end
clear s ss x1 x2 xx1 xx2 a

%% 计算曲线
yy1=zeros(1,180001);
yy1(1)=y1(1);
for a=2:180001;
    yy1(a)=yy1(a-1)-c1(a)/300*(xa(a)-250)/300-b1(a)/300;
end
clear a
plot(x,y1,x([1:180001]),yy1,'*r')

%% 误差
y1cha=yy1-y1;
% y1chaz=sum(abs(y1cha));
% y1chaj=mean(abs(y1cha));
% y1cham=max(abs(y1cha));

%% 绘图
subplot(2,2,1)
plot(xa,y1,xa,yy1,'r')
subplot(2,2,2)
plot(xa,y1cha)
subplot(2,2,3)
plot(xa,b1)
subplot(2,2,4)
plot(xa,c1)

%% 计算方案合理性
k=-1;
s=0;
ss=zeros(1,180001);
for a=1:180001;
    k=k+1;
    if k>3000;
        k=0;
        s=0;
    else
        if abs(b1(a))>0;
            s=s+1;
        end
        ss(a)=s;
        k=k;
    end
end
clear a k s

s=zeros(1,180001);
for a=6001:3000:180001;
    s(a)=abs(ss(a)-ss(a-3000))/ss(a-3000);
end
clear a

k=3001;
s=zeros(1,60);
for a=1:60;
s(a)=ss(k);
k=k+3000;
end
clear a k
    
k=zeros(1,60);
 for a=2:60;
     k(a)=abs(s(a)-s(a-1))/s(a-1);
 end
 clear a
     
