function [g r]=abjiaodu(meadata) %ab平面转角和半径 %角度变换
n=length(meadata(:,1));
a=meadata(:,2);b=meadata(:,3);
g=atan(b./a);
if a(1)<0&&b(1)>0 
    g=g+pi;
end
if a(1)<0&b(1)<0 
    g=g+pi;
end
r=(a.^2+b.^2).^0.5;