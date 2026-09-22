%求初始速度最优值
function [disum,opt_a,opt_b,opt_c,opt_k,opt_m0]=distance32()
global opt_ln6
global opt_ln9
global ts
global y0
global k
global m0
global c
global cuixianduan3

load opt_ln6.mat
load opt_ln9.mat
load cuixianduan3.txt

a06=opt_ln6(:,2);
b06=opt_ln6(:,3);
c06=opt_ln6(:,4);
d06=opt_ln6(:,5);

a09=opt_ln9(:,2);
b09=opt_ln9(:,3);
c09=opt_ln9(:,4);
d09=opt_ln9(:,5);
kk=length(a06);
ts=opt_ln6(:,1);


count=0;
disum=inf;
opt_a=0;
opt_b=0;
opt_c=0;
opt_k=0;
opt_m0=0;
%y0=[-1112138.62556717,-798.799170331639,6200400.27673336,738.057616106497,1133222.51025844,950.241633404006];
% 1.2126e+005
%k=21.2;m0=0.0037;
for a=-773.660:0.0002:-773.658
    for b=738.726:0.0002:738.728
        for c=920.604:0.0002:920.606
            for k=21.7:21.7
                for m0=0.0036:0.0036
y0=[-1120528.80725998,a,6178864.35550883,b,1123644.39890016,c];


[X,Y]=feixingqi(y0,k,m0);
x=Y(:,1);
y=Y(:,3);
z=Y(:,5);

MP06=[x,y,z]-[zeros(kk,1),b06,d06];
cos1=MP06.*[ones(kk,1),a06,c06];
cos06=(cos1(:,1)+cos1(:,2)+cos1(:,3))./sqrt(MP06(:,1).^2+MP06(:,2).^2+MP06(:,3).^2)./sqrt(1+a06.^2+c06.^2);     
sin06=sqrt(abs(1-cos06.^2));
%for n=1:kk
  % if 1-abs(cos06(n))<=10^(-15)
       % sin06(n)=0;
    %end
%end
dd06=sqrt(MP06(:,1).^2+MP06(:,2).^2+MP06(:,3).^2).*sin06;
dsum06=sum(dd06);

MP09=[x,y,z]-[zeros(kk,1),b09,d09];
cos2=MP09.*[ones(kk,1),a09,c09];
cos09=(cos2(:,1)+cos2(:,2)+cos2(:,3))./sqrt(MP09(:,1).^2+MP09(:,2).^2+MP09(:,3).^2)./sqrt(1+a09.^2+c09.^2);
sin09=sqrt(abs(1-cos09.^2));
dd09=sqrt(MP09(:,1).^2+MP09(:,2).^2+MP09(:,3).^2).*sin09;
dsum09=sum(dd09);
dsum=dsum06+dsum09;



count=count+1

if dsum<disum
    disum=dsum;
    opt_a=a;
    opt_b=b;
    opt_c=c;
    opt_k=k;
    opt_m0=m0;
end
                end
            end
        end
    end
 end
          

function[X,Y]=feixingqi(y0,k,m0)
global opt_ln6
global opt_ln9
global y0
ts=opt_ln6(:,1);
options=odeset('abstol',10^(-7));  
[X,Y]=ode45(@fun2,ts,y0,options);

function z=fun2(x,y)
Gm=3.986005*10^14;
global k
global m0
z(1,:)=y(2);
z(2,:)=-Gm./(y(1).^2+y(3).^2+y(5).^2).^1.5.*y(1)+y(2)./((y(2).^2+y(4).^2+y(6)).^0.5).*(k/(1-m0*(x-50.1812189092689990)));
z(3,:)=y(4);
z(4,:)=-Gm./(y(1).^2+y(3).^2+y(5).^2).^1.5.*y(3)+y(4)./((y(2).^2+y(4).^2+y(6)).^0.5).*(k/(1-m0*(x-50.1812189092689990)));
z(5,:)=y(6);
z(6,:)=-Gm./(y(1).^2+y(3).^2+y(5).^2).^1.5.*y(5)+y(6)./((y(2).^2+y(4).^2+y(6)).^0.5).*(k/(1-m0*(x-50.1812189092689990)));