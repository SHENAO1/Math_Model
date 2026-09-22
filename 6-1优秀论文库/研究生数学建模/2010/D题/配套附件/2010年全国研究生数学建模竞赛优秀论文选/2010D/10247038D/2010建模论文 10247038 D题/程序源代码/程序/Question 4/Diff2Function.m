function [ Y ] = Diff2Function(X )
%DIFF2FUNCTION Summary of this function goes here
%   Detailed explanation goes here

Y = (3/16000-3/1000)*exp(-X/400)*sin(1/100*(X+25*pi)) - 6/4000*exp(-X/400)*cos(1/100*(X+25*pi));

end

