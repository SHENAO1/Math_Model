function G = dudt_func2(x,t)
global omiga
global n
sum=0;
for i=1:n
    sum=sum+(i*omiga.*P_func(i,x).*cos(i*omiga*t)-i*omiga.*O_func(i,x).*sin(i*omiga*t));
end
G=sum.*sum;
end