function [xm1 fm1 xm2 fm2 phase]=spacecon(paraz,l)
global para;
global Tst;
paraz=paraz';
x=zeros(5,6);
l=[0 l];
v=10;
for i=[1 3 4 5]
    [x(:,i) fval(i)]=fb4(paraz(:,i));
end
for i=[2 6]
    [x(:,i) fval(i)]=fb3(paraz(:,i));
end
[Tst,pos]=max(x(5,:));
Tb=Tst-x(5,:);
xm1(1,:)=(x(1,:).*x(5,:)+Tb)./(Tb+x(5,:));
for i=2:4
    xm1(i,:)=(x(i,:).*x(5,:))./(Tb+x(5,:));
end
xm1(5,:)=Tb+x(5,:);
fm1=zeros(1,6);
for i=[1 3 4 5]
    para=paraz(:,i);
    fm1(i)=fbfun4(xm1(:,i));
end
xs=[xm1([1 2 3 5],:)];
for i=[2 6]
    para=paraz(:,i);
    fm1(i)=fbfun3(xs(:,i));
end

for i=[1 3 4 5]
    [xm2(:,i) fm2(i)]=fbt4(paraz(:,i));    
end
for i=[2 6]
    [xm2(:,i) fm2(i)]=fbt3(paraz(:,i));
end

for i=1:6
delay1(i)=l(i)/v;
delay2(i)=xm2(5,i)*(1-xm2(1,i))*paraz(1,i)/(paraz(3,i)-paraz(1,i));
end
phase=cumsum(delay1)-delay2+delay2(1);