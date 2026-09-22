function [ER,OrderList] = Optimization(DeltaL)
%OPTIMIZATION Summary of this function goes here
%   Detailed explanation goes here
b = 250;

i = 1; tmpX= 0;
while round((350-tmpX)/DeltaL)>0
    BPointList(i,1) = DeltaL*(i-1) - b;
    tmpX = BPointList(i,1);
    BPointList(i,2) = Function(tmpX + b);
    i = i + 1;
end
LastDeltaL = 350-tmpX;
if LastDeltaL > 0 
    BPointList(i,1) = 350;
    BPointList(i,2) = Function(350 + b);
end


BRealPointList = zeros(2,2);
OrderList = zeros(2,3);

%³õÖµ
DeltaSit = -atan(-1/DiffFunction(0))-pi/2;
AP0(1) = -b*cos(DeltaSit)-Function(0)*sin(DeltaSit);
AP0(2) = -b*sin(DeltaSit)+Function(0)*cos(DeltaSit);

BRealPointList(1,:) = [-250 130];
APB = [0 0 DeltaSit];

j = 2;
Dis = -100;
while Dis<0
    [BRealPointList(j,:),OrderList(j-1,:),APB] = Equation(DeltaL,APB,AP0,BRealPointList(j-1,:));
    Dis = BRealPointList(j,1)-350;
    j = j + 1;
end

[MaxError,MeanError] = ErrorCal(BRealPointList);
ER = MaxError/10 + MeanError;
% plot(BPointList(:,1),BPointList(:,2));hold on;plot(BRealPointList(:,1),BRealPointList(:,2));
% plot(PointList(1:69,1),PointList(1:69,2));hold on;plot(Result(1:69,1),Result(1:69,2));
end


