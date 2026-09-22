function G=F_func(x,t)
global omiga
global n;
global Er;
global A1g;
global sigama;
global v;
global deta;
sum=0;
for i=1:n
  sum=sum+(O1_func(i,x)*cos(i*omiga*t)+P1_func(i,x)*sin(i*omiga*t));
end
G= 0.5*sigama(1)+Er*A1g*sum;
end