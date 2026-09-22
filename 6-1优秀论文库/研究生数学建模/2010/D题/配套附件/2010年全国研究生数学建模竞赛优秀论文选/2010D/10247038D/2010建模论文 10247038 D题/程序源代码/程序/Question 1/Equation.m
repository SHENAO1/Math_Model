function [CurPoint,deltaO,APB] = Equation(deltaL,LastPoint,StartPoint,BLast)
%EQUATION Summary of this function goes here
%   Detailed explanation goes here
% w = 10;
% o = 1;
% h = 12;
% R = 300;
% SF=(o*h)/(360*w*R);
R = 300;
b = 250;
S0=1/300;

PX0 = StartPoint(1);
PY0 = StartPoint(2);

LPX0 = LastPoint(1);
LPY0 = LastPoint(2);
LPF0 = LastPoint(3);

X0 = BLast(1);
Y0 = BLast(2);

deltaF = atan1(1/DiffFunction(LPX0+b),1/DiffFunction(LPX0+deltaL+b));
deltaX = PX0 - cos(LPF0+deltaF)*(X0+deltaL) + sin(LPF0+deltaF)*Function(X0+deltaL+b) - LPX0;
deltaY = PY0 - sin(LPF0+deltaF)*(X0+deltaL) - cos(LPF0+deltaF)*Function(X0+deltaL+b) - LPY0;

deltaO(1) = round(deltaX/S0);
deltaO(2) = round(deltaY/S0);
deltaO(3) = round(tan(deltaF)*R/S0);

deltaX = deltaO(1)*S0;
deltaY = deltaO(2)*S0;
deltaF = atan(deltaO(3)*S0/R);

APB(1) = LPX0 + deltaX;
APB(2) = LPY0 + deltaY;
APB(3) = LPF0 + deltaF;

% Êµ¼Êµã
CurPoint(1) = (PX0-LPX0-deltaX)*cos(LPF0+deltaF) + (PY0-LPY0-deltaY)*sin(LPF0+deltaF);
CurPoint(2) =-(PX0-LPX0-deltaX)*sin(LPF0+deltaF) + (PY0-LPY0-deltaY)*cos(LPF0+deltaF);

end

