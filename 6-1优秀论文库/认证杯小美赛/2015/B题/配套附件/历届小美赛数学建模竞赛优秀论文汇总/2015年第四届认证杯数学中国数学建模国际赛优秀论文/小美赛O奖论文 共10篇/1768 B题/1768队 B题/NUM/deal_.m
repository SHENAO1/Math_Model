clear; %b为大陆年变化，可得出图，可以可调
load NUM_ALL.mat
NU = NUM_ALL;
key_ = 14/29;
NU(:,:,30) = NU(:,:,30)*key_;
NU(:,:,1:29) = NU(:,:,1:29)*((1-key_)/29);
a = sum(NU,3);
b = mean(a,2)';
b(25) = -26;
x = 1991:2015;
A=polyfit(x,b,1);  
A1=polyfit(x,b,5); 
y1=polyval(A,x);
plot(x,b,'*--'); 
hold on;
plot(x,y1,'r-','LineWidth',3);

y1=polyval(A1,x);
plot(x,y1,'.-','LineWidth',4);