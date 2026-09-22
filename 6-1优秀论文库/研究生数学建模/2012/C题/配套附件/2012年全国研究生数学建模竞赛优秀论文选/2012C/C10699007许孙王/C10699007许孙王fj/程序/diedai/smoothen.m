function y = smoothen(x)
len = length(x);

x1 = x([len-1,  len, 1:len-2]);
x2 = x([len,    1:len-1]);
x3 = x([2:len,  1]);
x4 = x([3:len,  1,  2]);

y = (x1+x2+x+x3+x4)/5;

end
