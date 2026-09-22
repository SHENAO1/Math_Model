function [x fval]=fb4(paraz)
x0=[0.2;0.2;0.2;0.2;20];
LB=zeros(5,1);
A=[0 0 0 0 1];
B=[200];
global para;
para=paraz;
warning off all;
[x fval]=fmincon('fbfun4',x0,A,B,[],[],LB,[],'confun4');