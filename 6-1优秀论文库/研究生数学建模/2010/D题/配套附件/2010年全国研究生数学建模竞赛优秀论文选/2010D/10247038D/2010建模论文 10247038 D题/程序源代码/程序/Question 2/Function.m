function [Y] = Function(X)
%FUNCTION Summary of this function goes here
%   Detailed explanation goes here
Y = 30*exp(-X/400)*sin(1/100*(X+25*pi))+130;
end

