function [x fval]=fbt3(paraz)
x0=[0.2;0.2;0.2;20];
LB=zeros(4,1);
Aeq=[0 0 0 1];
global Tst;
Beq=Tst;
global para;
para=paraz;
[x fval]=fmincon('fbfun3',x0,[],[],Aeq,Beq,LB,[],'confun3');
x=[x(1);x(2);x(3);0;x(4)];