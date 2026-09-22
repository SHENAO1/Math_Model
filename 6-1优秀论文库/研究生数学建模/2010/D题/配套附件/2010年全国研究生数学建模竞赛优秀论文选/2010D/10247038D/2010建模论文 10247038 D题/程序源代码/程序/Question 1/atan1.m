function [nd] = atan1(x,y)
%TAN1 Summary of this function goes here
%   Detailed explanation goes here
if x>500
    nd = (atan(x+y)/(1-x*y));
    return;
end
if y>500
    nd = (atan(x+y)/(1-x*y));
    return;
end
    nd = atan(x)-atan(y);
end

