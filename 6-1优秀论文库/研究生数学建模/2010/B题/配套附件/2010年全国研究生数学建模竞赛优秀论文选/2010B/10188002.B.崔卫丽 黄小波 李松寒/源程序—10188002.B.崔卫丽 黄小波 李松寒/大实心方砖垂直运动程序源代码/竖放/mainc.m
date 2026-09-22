clc,clear
[TT,YY]=ode45(@odefun,0:0.01:0.2,[0.275  0]);
subplot(3,1,1)
plot(TT,YY(:,1),'r-*',TT,YY(:,2),'b--')
xlabel('单位/s');ylabel('单位/m')
title('物体重心在水面运动轨迹')
 
[TT,YY]=ode45(@odefun,0:0.01:0.2,[0.325  0.4472]);
subplot(3,1,2)
plot(TT,YY(:,1),'r-*',TT,YY(:,2),'b--')
xlabel('单位/s');ylabel('单位/m')
title('物体重心距离水面5cm运动轨迹')
 
[TT,YY]=ode45(@odefun,0:0.01:0.2,[0.395  1.2649]);
subplot(3,1,3)
plot(TT,YY(:,1),'r-*',TT,YY(:,2),'b--')
xlabel('单位/s ');ylabel('单位/m ')
title('物体重心距离水面12cm运动轨迹')

