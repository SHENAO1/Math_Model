%mdata0_60=gdata_60(:,2:3);
%mdata0_90=gdata_60(:,2:3);
global posi00_2
%alpha_60,beta_60,alpha_90,beta_90最终迭代得到校正系统误差后的alpha、beta值
alpha_60=mdata0_60(:,1);
beta_60=mdata0_60(:,2);
alpha_90=mdata0_90(:,1);
beta_90=mdata0_90(:,2);
R06=sqrt(posi_06(:,1).^2+posi_06(:,2).^2+posi_06(:,3).^2);
R09=sqrt(posi_09(:,1).^2+posi_09(:,2).^2+posi_09(:,3).^2);
posi00_2=zeros(600,3);
D6=zeros(1,3);
D9=zeros(1,3);
%贪婪算法搜索迭代一千次
for j=1:1000
%逐点交汇求解当前alpha_60,beta_60,alpha_90,beta_90对应的飞行器位置posi00_2    
for i=1:600
A=[(alpha_90(i)*cos(Bs_9(i))*cos(Ls_9(i))+sin(Ls_9(i))),(alpha_90(i)*cos(Bs_9(i))*sin(Ls_9(i)) - cos(Ls_9(i))),alpha_90(i)*sin(Bs_9(i))
(beta_90(i)*cos(Bs_9(i))*cos(Ls_9(i))+cos(Ls_9(i))*sin(Bs_9(i))),(beta_90(i)*cos(Bs_9(i))*sin(Ls_9(i))+sin(Bs_9(i))*sin(Ls_9(i))),(beta_90(i)*sin(Bs_9(i))- cos(Bs_9(i)))
 (alpha_60(i)*cos(Bs_6(i))*cos(Ls_6(i))+sin(Ls_6(i))), (alpha_60(i)*cos(Bs_6(i))*sin(Ls_6(i)) - cos(Ls_6(i))),alpha_60(i)*sin(Bs_6(i))
(beta_60(i)*cos(Bs_6(i))*cos(Ls_6(i))+cos(Ls_6(i))*sin(Bs_6(i))),(beta_60(i)*cos(Bs_6(i))*sin(Ls_6(i))+sin(Bs_6(i))*sin(Ls_6(i))),(beta_60(i)*sin(Bs_6(i))- cos(Bs_6(i)))
  ];
B=[alpha_90(i)*R09(i); beta_90(i)*R09(i);alpha_60(i)*R06(i); beta_60(i)*R06(i)];
 
posi00_2(i,:)=(A\B)';
%cancha(i,:)=(A*posi00_2(i,:)'-B)';
end
%坐标系转换得到观测坐标系下飞行器位置坐标posi60_1，posi90_1
posi60_1=zeros(600,3);
posi90_1=zeros(600,3);
for i=1:600
posi60_1(i,:)=posi00_2(i,:)*[cos(Ls_6(i)),-sin(Ls_6(i)),0;sin(Ls_6(i)),cos(Ls_6(i)),0;0,0,1]*[cos(Bs_6(i)),0,-sin(Bs_6(i));0,1,0;sin(Bs_6(i)),0,cos(Bs_6(i))]-[R06(i),0,0];
posi90_1(i,:)=posi00_2(i,:)*[cos(Ls_9(i)),-sin(Ls_9(i)),0;sin(Ls_9(i)),cos(Ls_9(i)),0;0,0,1]*[cos(Bs_9(i)),0,-sin(Bs_9(i));0,1,0;sin(Bs_9(i)),0,cos(Bs_9(i))]-[R09(i),0,0];
end
%计算由逐点交汇求得的坐标对应的alpha，beta
altha60_1=posi60_1(:,2)./posi60_1(:,1);
beta60_1=posi60_1(:,3)./posi60_1(:,1);
altha90_1=posi90_1(:,2)./posi90_1(:,1);
beta90_1=posi90_1(:,3)./posi90_1(:,1);
da6=alpha_60-altha60_1;
db6=beta_60-beta60_1;
da9=alpha_90-altha90_1;
db9=beta_90-beta90_1;
if j==1
close all
figure(1)

subplot(2,2,1)
plot(beta60_1,da6)
xlabel('\beta_6')
ylabel('校正系统误差前的误差 D\alpha_6')
subplot(2,2,2)
plot(altha60_1,db6)
xlabel('\alpha_6')
ylabel('校正系统误差前的误差 D\beta_6')
subplot(2,2,3)
plot(beta90_1,da9)
xlabel('\beta_9')
ylabel('校正系统误差前的误差 D\alpha_9')
subplot(2,2,4)
plot(altha90_1,db9)
xlabel('\alpha_9')
ylabel('校正系统误差前的误差 D\beta_9')
end
D_a6=polyfit(mdata0_60(:,2),da6,1);
D_b6=polyfit(mdata0_60(:,1),db6,1);
D_a9=polyfit(mdata0_90(:,2),da9,1);
D_b9=polyfit(mdata0_90(:,1),db9,1);

Dthe6=(D_a6(1)-D_b6(1))/2;
Dthe9=(D_a9(1)-D_b9(1))/2;
Dalpha_6=(D_a6(1)-Dthe6)*mean(mdata0_60(:,2))+D_a6(2);
Dbeta_6=(-D_b6(1)-Dthe6)*mean(mdata0_60(:,1))+D_b6(2);
Dalpha_9=(D_a9(1)-Dthe9)*mean(mdata0_90(:,2))+D_a9(2);
Dbeta_9=(-D_b9(1)-Dthe9)*mean(mdata0_90(:,1))+D_b9(2);

%新的系统误差值
D6(1)=D6(1)+Dalpha_6;
D6(2)=D6(2)+Dbeta_6;
D6(3)=D6(3)+Dthe6;
D9(1)=D9(1)+Dalpha_9;
D9(2)=D9(2)+Dbeta_9;
D9(3)=D9(3)+Dthe9;
%计算新的alpha_60,beta_60,alpha_90,beta_90
alpha_60=(mdata0_60(:,1)-D6(1))*cos(D6(3))-(mdata0_60(:,2)-D6(2))*sin(D6(3));
beta_60=(mdata0_60(:,2)-D6(2))*cos(D6(3))+(mdata0_60(:,1)-D6(1))*sin(D6(3));
alpha_90=(mdata0_90(:,1)-D9(1))*cos(D9(3))-(mdata0_90(:,2)-D9(2))*sin(D9(3));
beta_90=(mdata0_90(:,2)-D9(2))*cos(D9(3))+(mdata0_90(:,1)-D9(1))*sin(D9(3));
end
%从50.1783s间隔10秒的定位位置
answer3_1=posi00_2(1:50:600,:);
%画图

figure(2)
subplot(2,2,1)
plot(beta60_1,da6)
xlabel('\beta_6')
ylabel('校正系统误差后的误差 D\alpha_6')
subplot(2,2,2)
plot(altha60_1,db6)
xlabel('\alpha_6')
ylabel('校正系统误差后的误差 D\beta_6')
subplot(2,2,3)
plot(beta90_1,da9)
xlabel('\beta_9')
ylabel('校正系统误差后的误差 D\alpha_9')
subplot(2,2,4)
plot(altha90_1,db9)
xlabel('\alpha_9')
ylabel('校正系统误差后的误差 D\beta_9')