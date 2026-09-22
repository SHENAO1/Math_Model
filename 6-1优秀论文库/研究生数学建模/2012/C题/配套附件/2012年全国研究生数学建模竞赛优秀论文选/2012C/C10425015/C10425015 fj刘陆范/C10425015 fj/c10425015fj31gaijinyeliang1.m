clc
clear
%************************计算有效冲程并判断漏失位置**********************%
SH=1.999322075020867;
SL=2.524148292066544;
if SH>SL
    Spe=SL;
    flag=1;
else 
    Spe=SH;
    flag=0;
end
%************************计算产液量初值*****************************%
D=0.07;
%Bo=1.025;
N=7.6;
Ap=pi*D^2/4;
QL=1440*Spe*Ap*N;  %单位m3/d
Q=zeros(1,100);
nq=length(Q);
%************************产液量迭代计算*****************************%
% %0.239787	62.7546
% 0.734582	60.2195
% 2.61861	50.526
% -0.00125417	23.8461
% 1.96977	13.7052
wucha=0.05;
rou=8456;g=10;
Q0=QL;Ql=Q(1);
for i=1:nq
if abs((Ql-Q0))/Q0>=wucha
    Q0=Ql;
    Q(i)=Ql;
else
    break
     print(Ql)
end
sc=0.239787;fc=62.7546;
sd=0.734582;fd=60.2195;
sb= 2.61861;fb=50.526;
sa=-0.00125417;fa=23.8461;
sg=1.96977;fg=13.7052;
jiao=atan(abs((fc-fb)/(sc-sb)));
db=abs((sb-sd)/cos(jiao));
cb=abs((sb-sc)/cos(jiao));
ag=abs((sa-sg)/cos(jiao));
pru=0.2+rou*Q(i)*g/Ap/1440/3/10^6;
pchu=0.3+rou*Q(i)*g/Ap/1440/10^6;

w=pi*N/30;
Sgan=3.2;
deta=Spe/Sgan;
ksai=db/cb;
yitak=ag/cb;
m=1.12;   %m=1.12~1.13
theta=1/m;
b=pru/pchu;
yita=(yitak-b^theta)/(1-b^theta);
tad=acos(2*deta*ksai-1)/w;
tdb=acos(1-2*deta*ksai)/w;
tbg=acos(2*deta*yitak-1)/w;
arfa=(1-ksai)*(1-b)*(tad+tdb+tbg)/tad;

tbg=acos(2*deta*yitak-1)/w;
tga=acos(1-2*deta*yitak)/w;
tac=acos(2*deta*ksai-1)/w;
beta=(ksai-1)*(1-b)*(tbg+tga+tac)/tga;
if flag==1
    Ql=1440*Spe*N*(yita-arfa)*pi*D^2/4
else if flag==0
    Ql=1440*Spe*N*(yita-beta)*pi*D^2/4
    end
end
end
 Ql   




