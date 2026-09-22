%此程序的作用是画出200-500行均值的XZ轴的截面图


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%产生一个xz轴平面
load  F:\建模\题\6x2次棱数据\77T1-1203959\c1.dat 
load  F:\建模\题\6x2次棱数据\77T1-1203959\c2.dat
load   F:\建模\题\6x2次棱数据\77T1-1203959\c3.dat
load  F:\建模\题\6x2次棱数据\77T1-1203959\c4.dat

%load c1.dat
%size(c1)
for j=250:500;

i=1:564;      %x轴点的个数。
x(i)=0:0.00275:1.54825;
for i=1:564
    
    z1(i)=c1((564*(j-1))+i,3);
    z2(i)=c2((564*(j-1))+i,3);
    z3(i)=c3((564*(j-1))+i,3);
    z4(i)=c4((564*(j-1))+i,3);
end



zzz=zeros(1,564);
zzz1=lvbo(z1);
figure(1)
plot(x,zzz1)
xlabel('x轴坐标'); ylabel('滤波后的z轴值');title('c1,y轴250行到500行的截面图');
hold on
zzz2=lvbo(z2);
zzz3=lvbo(z3);
zzz4=lvbo(z4);
zzz10=0;
zzz20=0;
zzz30=0;
zzz40=0;
zzz10=zzz10+zzz1;
zzz20=zzz20+zzz2;
zzz30=zzz30+zzz3;
zzz40=zzz40+zzz4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%去掉前面的几个由误差的点后的截面
Z1=zzz1(40:524);
Z2=zzz2(40:524);
Z3=zzz3(40:524);
Z4=zzz4(40:524);
Z10=0;
Z20=0;
Z30=0;
Z40=0;
Z10=Z10+Z1;
Z20=Z20+Z2;
Z30=Z30+Z3;
Z40=Z40+Z4;
x1=x(40:524);
end
figure(2)
subplot(2,2,1)
plot(x,zzz10/251);
xlabel('x轴坐标'); ylabel('滤波后的z轴值');title('c1,y轴250行到500行均值的截面图');
%hold on
subplot(2,2,2)
plot(x,zzz20/251);
xlabel('x轴坐标'); ylabel('滤波后的z轴值');title('c2,y轴250行到500行均值的截面图');
%hold on
subplot(2,2,3)
plot(x,zzz30/251);
xlabel('x轴坐标'); ylabel('滤波后的z轴值');title('c3,y轴250行到500行均值的截面图');
%hold on
subplot(2,2,4)
plot(x,zzz40/251);
xlabel('x轴坐标'); ylabel('滤波后的z轴值');title('c4,y轴250行到500行均值的截面图');
%hold on

figure(3)
subplot(2,2,1)
plot(x1,Z10/251);
xlabel('x轴坐标'); ylabel('滤波后的z轴值');title('c1,y轴250行到500行均值的截面图');
%hold on
subplot(2,2,2)
plot(x1,Z20/251);
xlabel('x轴坐标'); ylabel('滤波后的z轴值');title('c2,y轴250行到500行均值的截面图');
%hold on
subplot(2,2,3)
plot(x1,Z30/251);
xlabel('x轴坐标'); ylabel('滤波后的z轴值');title('c3,y轴250行到500行均值的截面图');
%hold on
subplot(2,2,4)
plot(x1,Z40/251);

xlabel('x轴坐标'); ylabel('滤波后的z轴值');title('c4,y轴250行到500行均值的截面图');
%hold on
