%此程序的作用是画出200-500行的XZ轴的截面图


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
figure(2)
plot(x,zzz1)
xlabel('x轴坐标'); ylabel('滤波后的z轴值');title('c1,y轴250行到500行的截面图');
hold on

zzz2=lvbo(z2);
zzz3=lvbo(z3);
zzz4=lvbo(z4);

figure(3)

subplot(2,2,1)
plot(x,zzz1);
xlabel('x轴坐标'); ylabel('滤波后的z轴值');title('c1,y轴250行到500行的截面图');
hold on
subplot(2,2,2)
plot(x,zzz2);
xlabel('x轴坐标'); ylabel('滤波后的z轴值');title('c2,y轴250行到500行的截面图');
hold on
subplot(2,2,3)
plot(x,zzz3);
xlabel('x轴坐标'); ylabel('滤波后的z轴值');title('c3,y轴250行到500行的截面图');
hold on
subplot(2,2,4)
plot(x,zzz4);
xlabel('x轴坐标'); ylabel('滤波后的z轴值');title('c4,y轴250行到500行的截面图');
hold on


figure(4)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%去掉前面的几个由误差的点后的截面
Z1=zzz1(40:524);
Z2=zzz2(40:524);
Z3=zzz3(40:524);
Z4=zzz4(40:524);
x1=x(40:524);
subplot(2,2,1)
plot(x1,Z1);
xlabel('x轴坐标'); ylabel('滤波后的z轴值');title('c1,y轴250行到500行的截面图');
hold on
subplot(2,2,2)
plot(x1,Z2);
xlabel('x轴坐标'); ylabel('滤波后的z轴值');title('c2,y轴250行到500行的截面图');
hold on
subplot(2,2,3)
plot(x1,Z3);
xlabel('x轴坐标'); ylabel('滤波后的z轴值');title('c3,y轴250行到500行的截面图');
hold on
subplot(2,2,4)
plot(x1,Z4);

xlabel('x轴坐标'); ylabel('滤波后的z轴值');title('c4,y轴250行到500行的截面图');
hold on
end
