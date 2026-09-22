clear all %随机采样选取较优值
clc
load meadata_09_00.txt
load new06.txt
load mea09lc.txt
load mea06lc.txt
minlnds=10^9;count=0;
for a=1:10^6
    dg6=rand*0.1-0.05;
    da6=rand*0.1-0.05;
    db6=rand*0.01-0.005;
    dg9=rand*0.1-0.05;
    da9=rand*0.1-0.05;
    db9=rand*0.1-0.05;
[g6 r6]=abjiaodu(new06);
[g9 r9]=abjiaodu(meadata_09_00);%ab平面转角
n=length(meadata_09_00(:,1));
new06n=zeros(n,3);
new06n(:,1)=meadata_09_00(:,1);
new06n(:,2)=r6.*cos(g6+dg6)+da6;
new06n(:,3)=r6.*sin(g6+dg6)+db6;%6观测角系统误差加入

meadata_09_00n=zeros(n,3);
meadata_09_00n(:,1)=meadata_09_00(:,1);
meadata_09_00n(:,2)=r9.*cos(g9+dg9)+da9;
meadata_09_00n(:,3)=r9.*sin(g9+dg9)+db9;

stot6=zuobiaobianhuan(mea06lc,new06n);
stot9=zuobiaobianhuan(mea09lc,meadata_09_00n);
ln6=qiuln(stot6,mea06lc);
ln9=qiuln(stot9,mea09lc);
lnds=line_distance(ln6,ln9);
sumlnds=sum(lnds(:,2));
if sumlnds<minlnds
    minlnds=sumlnds;
    d=[dg6 da6 db6;dg9 da9 db9];
end
count=count+1
    
end
minlnds
d
