global r c1 c2;
G=3.986005e14;
%以差分代替微分，并平滑滤波，窗口大小为9
r=posi00_1(1:end,:);
r(:,1)=smooth(r(:,1),9);
r(:,2)=smooth(r(:,2),9);
r(:,3)=smooth(r(:,3),9);
dr=(r(2:end,:)-r(1:end-1,:))/0.2;
dr(:,1)=smooth(dr(:,1),9);
dr(:,2)=smooth(dr(:,2),9);
dr(:,3)=smooth(dr(:,3),9);
ddr=(dr(2:end,:)-dr(1:end-1,:))/0.2;
ddr(:,1)=smooth(ddr(:,1),9);
ddr(:,2)=smooth(ddr(:,2),9);
ddr(:,3)=smooth(ddr(:,3),9);
r=r(1:end-2,:);
dr=dr(1:end-1,:);
    
power=zeros(598,1);
for i=1:598
power(i)=1/norm(ddr(i,:)+G/(norm(r(i,:)))^3.*(r(i,:)));
end

%c1*t+c2图
plot(time(1:end-2),power,'.')
xlabel('t(s)')
ylabel('c_1t + c_2')

%一阶线性拟合
C=polyfit(time(6:end-7),power(6:end-5),1);
%与m、v有关的两个参数c1,c2
c1=C(1);c2=C(2);