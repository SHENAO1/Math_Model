clc,clear
[TT,YY]=ode45(@odefun,0:0.01:0.2,[0.04  0]);
plot(TT,YY(:,1),'r-*')
xlabel('单位/s');ylabel('单位/m')
title(' 大方砖平放')


