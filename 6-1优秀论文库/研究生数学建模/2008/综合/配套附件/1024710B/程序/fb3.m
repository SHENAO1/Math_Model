function [x fval]=fb3(paraz)
x0=[0.2;0.2;0.2;20];
LB=zeros(4,1);
A=[0 0 0 1];
B=[200];
global para;
para=paraz;
warning off all;
[x fval]=fmincon('fbfun3',x0,A,B,[],[],LB,[],'confun3');
x=[x(1);x(2);x(3);0;x(4)];