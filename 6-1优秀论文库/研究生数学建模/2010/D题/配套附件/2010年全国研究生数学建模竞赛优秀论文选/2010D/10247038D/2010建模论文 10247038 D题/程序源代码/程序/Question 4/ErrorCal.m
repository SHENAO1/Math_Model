function [MaxError,MeanError] = ErrorCal(RealPointList)
%ERRORCAL Summary of this function goes here
%   Detailed explanation goes here

[N,M] = size(RealPointList);
n = round(6000/N);
MaxError = 0;
k = 1;
for i =2:N
    RealStartP = RealPointList(i-1,1:2);
    RealEndP = RealPointList(i,1:2);
    %Error(i-1) = sqrt((RealEndP(1)-ThEndP(1))^2 + (RealEndP(2)-ThEndP(2))^2);
    for j=1:n
        Point = (1*j/n)*(RealEndP-RealStartP)+RealStartP;
        X = Point(1);
        Y = Function(X+250);
        Error(k) = Y-Point(2);
        k = k + 1;
        if Error>MaxError
            MaxError = Error;
            XR = X;
        end
    end
end

MaxError = max(Error);
MeanError = mean(abs(Error));


end

