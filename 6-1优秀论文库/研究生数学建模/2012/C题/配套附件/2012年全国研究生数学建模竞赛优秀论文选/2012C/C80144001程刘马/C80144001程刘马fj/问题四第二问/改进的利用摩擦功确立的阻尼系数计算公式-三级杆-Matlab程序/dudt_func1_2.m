function G = dudt_func1_2(x,t)
global omiga
global n
sum=0;
h=3;
for i=1:n
    sum=sum+(i*omiga.*P_func2(h,i,x).*cos(i*omiga*t)-i*omiga.*O_func2(h,i,x).*sin(i*omiga*t));
end
G=sum*dudt_func_2(618.35,t);
end