clear all  %求中点
clc
load opt_ln6.mat
load opt_ln9.mat
n=length(opt_ln6(:,1));
lna=zeros(17,n);
lnaa=lna(1,:);
lnab=lna(2,:);
lnac=lna(3,:);
lnad=lna(4,:);%F飞行器所在最置信直线方程
x6=lna(5,:);
y6=lna(6,:);
z6=lna(7,:);
x9=lna(8,:);
y9=lna(9,:);
z9=lna(10,:);%直线与6、9卫星的交点
d=lna(11,:);
xm=lna(12,:);
ym=lna(13,:);
zm=lna(14,:);
xm1=lna(15,:);
ym1=lna(16,:);
zm1=lna(17,:);
for i=1:n;
A=[opt_ln6(i,2) opt_ln6(i,4);opt_ln9(i,2) opt_ln9(i,4)];
B=[-1;-1];
lnaac=inv(A)*B;
lnaa(i)=lnaac(1);
lnac(i)=lnaac(2);%求ac
AA=[(opt_ln6(i,2)-lnaa(i)) 0 -1 0;(opt_ln6(i,4)-lnac(i)) 0 0 -1;
    0 (opt_ln9(i,2)-lnaa(i)) -1 0;0 (opt_ln9(i,4)-lnac(i)) 0 -1];%方程矩阵 x6 x9 ba da
BB=[-opt_ln6(i,3);-opt_ln6(i,5);-opt_ln9(i,3);-opt_ln9(i,5)];
lnabd=inv(AA)*BB;
lnab(i)=lnabd(3);
lnad(i)=lnabd(4);
x6(i)=lnabd(1);y6(i)=opt_ln6(i,2)*x6(i)+opt_ln6(i,3);z6(i)=opt_ln6(i,4)*x6(i)+opt_ln6(i,5);
x9(i)=lnabd(2);y9(i)=lopt_n9(i,2)*x9(i)+opt_ln9(i,3);z9(i)=opt_ln9(i,4)*x9(i)+opt_ln9(i,5);
d(i)=((x9(i)-x6(i))^2+(y9(i)-y6(i))^2+(z9(i)-z6(i))^2)^0.5;
xm(i)=0.5*(x6(i)+x9(i));
ym(i)=0.5*(y6(i)+y9(i));
zm(i)=0.5*(z6(i)+z9(i));
%cuizhi=1+ln6(i,2)*lnaa(i)+ln6(i,4)*lnac(i)
end
for i=1:n-1
    xm1(i)=(xm(i+1)-xm(i))/0.2;
    ym1(i)=(ym(i+1)-ym(i))/0.2;
    zm1(i)=(zm(i+1)-zm(i))/0.2;
end;
lna(1,:)=lnaa;
lna(2,:)=lnab;
lna(3,:)=lnac;
lna(4,:)=lnad;%F飞行器所在最置信直线方程
lna(5,:)=x6;
lna(6,:)=y6;
lna(7,:)=z6;
lna(8,:)=x9;
lna(9,:)=y9;
lna(10,:)=z9;%直线与6、9卫星的交点
lna(11,:)=d;
lna(12,:)=xm;
lna(13,:)=ym;
lna(14,:)=zm;
lna(15,:)=xm1;
lna(16,:)=ym1;
lna(17,:)=zm1;