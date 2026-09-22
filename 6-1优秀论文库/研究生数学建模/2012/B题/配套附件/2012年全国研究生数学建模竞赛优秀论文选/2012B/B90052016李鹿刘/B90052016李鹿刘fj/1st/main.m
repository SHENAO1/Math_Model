
clear all;clc;
format long;
%%%定步长rugga-kutta方法
h=1;
tmin=0;
tmax=250;
n=1+(tmax-tmin)/h;
y=zeros(6,n);
x=zeros(1,n);
y(:,1)=[ 2043922.166765 ; -5379.544693; 8186504.631471;   -407.095342 ;  4343461.714791 ;     3516.052656];%%初值                       
%%%%y(:,i)的物理意义-->[x vx y vy z vz]';
x(1)=0;
for i=2:n
    x(i)=x(i-1)+h;
    k1=vdp(y(:,i-1));
    k2=vdp(y(:,i-1)+h*k1/2);
    k3=vdp(y(:,i-1)+h*k2/2);
    k4=vdp(y(:,i-1)+h*k3);
    y(:,i)=y(:,i-1)+h*(k1+2*k2+2*k3+k4)/6; %按照龙格库塔方法进行数值求解
end


