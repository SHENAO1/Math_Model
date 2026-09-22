function [x fval]=fbt4(paraz)
x0=[0.2;0.2;0.2;0.2;20];
LB=zeros(5,1);
Aeq=[0 0 0 0 1];
global Tst;
Beq=Tst;
global para;
para=paraz;
[x fval]=fmincon('fbfun4',x0,[],[],Aeq,Beq,LB,[],'confun4');