function G = dudt_func2_2(x,t)
global omiga
global n
h=3;
sum=0;
for i=1:n
    sum=sum+(i*omiga.*P_func2(h,i,x).*cos(i*omiga*t)-i*omiga.*O_func2(h,i,x).*sin(i*omiga*t));
end
G=sum.*sum;
end