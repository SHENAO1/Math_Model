clear
clc
a=4.315;
b=2.495;
L=3.675;
H=3.625;
I=2.495;
r=0.95;
n=7.6;
s=3.2;

% a=3;
% b=2.4;
% L=3.35;
% H=3.27;
% I=2.3;
% r=0.985;
% n=9;
% s=2.5;
t=0:0.1:8;
k=length(t);
ksai=zeros(1,k);
J=zeros(1,k);
theta=zeros(1,k);
w=2*pi*n/60;
fai=w*t;
K=sqrt(I^2+H^2);
fai0=atan(I/H);
%**************精确解模型**********************%
for i=1:k  
J(i)=sqrt((I+r*sin(fai(i)))^2+(H-r*cos(fai(i)))^2);
ksai(i)=atan((I+r*sin(fai(i)))/(H-r*cos(fai(i))));
c(i)=(b^2+J(i)^2-L^2)/(2*b*J(i));
% if c(i)>1 
%    c(i)=1;
% end
theta(i)=pi-acos(c(i))-ksai(i);
sA(i)=a*(theta(i)-theta(1));
dtheta(i)=w*r*(K*sin(fai(i)+fai0)+b*sin(fai(i)-theta(i)))/(b*J(i)*sin(theta(i)+ksai(i)));
vA(i)=a*dtheta(i);
ddtheta(i)=(w^2*r*(K*cos(fai(i)+fai0)+b*cos(fai(i)-theta(i)))-2*b*w*r*dtheta(i)*cos(fai(i)+theta(i))-dtheta(i)^2*cos(theta(i)+ksai(i)))/(b*J(i)*sin(theta(i)+ksai(i)));
aA(i)=a*ddtheta(i);
end

plot(fai,sA,'b-',fai,vA,'r-',fai,aA,'p-')
axis([0 7 -2 4])
title('精确解模型')
xlabel('曲柄转角φ/rad');ylabel('位移S/m');
%**********简谐运动模型*********************%
for i=1:k
    ssA(i)=a/b*r*(1-cos(fai(i)));
    vvA(i)=a/b*w*r*sin(fai(i));
    aaA(i)=a/b*w^2*r*cos(fai(i));
end
%**************曲柄滑块模型*****************%
for i=1:k
    sssA(i)=r*(1-cos(fai(i))+r/L/2*(sin(fai(i)))^2)*a/b;
    vvvA(i)=w*r*(sin(fai(i))+r/L/2*sin(2*fai(i)))*a/b;
    aaaA(i)=w^2*r*(cos(fai(i))+r/L*cos(2*fai(i)))*a/b;
end
figure(1)
plot(fai,sA,'+-',fai,ssA,'*-',fai,sssA,'o-')
title('位移曲线')
xlabel('曲柄转角φ/rad');ylabel('位移S/m');

figure(2)
plot(fai,vA,'+-',fai,vvA,'*-',fai,vvvA,'o-')
title('速度曲线')
xlabel('曲柄转角φ/rad');ylabel('速度V/(m/s)');

figure (3)
plot(fai,aA,'+-',fai,aaA,'*-',fai,aaaA,'o-')
title('加速度曲线')
xlabel('曲柄转角φ/rad');ylabel('加速度α/(m/s^2)');


