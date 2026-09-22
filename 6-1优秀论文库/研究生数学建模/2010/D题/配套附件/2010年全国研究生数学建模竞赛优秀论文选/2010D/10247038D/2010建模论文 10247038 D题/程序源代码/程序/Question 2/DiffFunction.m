function [ Y ] = DiffFunction( X )
%DIFFFUNCTION Summary of this function goes here
%   Detailed explanation goes here
Y = (-30/400)*exp(-X/400)*sin(1/100*(X+25*pi)) + (30/100)*exp(-X/400)*cos(1/100*(X+25*pi));

end

