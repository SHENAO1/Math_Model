clc
clear
%************************计算有效冲程并判断漏失位置**********************%
SH=3.520326828900187;
SL=3.539593061057497;
if SH>SL
    Spe=SL;
    flag=1;
else 
    Spe=SH;
    flag=0;
end
%************************计算产液量初值*****************************%
D=0.044;
%Bo=1.025;
N=4;
Ap=pi*D^2/4;
QL=1440*Spe*Ap*N;  %单位m3/d
Q=zeros(1,100);
nq=length(Q);
%************************产液量迭代计算*****************************%
% 0.411025	70.1685
% 0.773694	70.1727
% 4.82592	70.2794
% 0.00483559	45.4254
% 3.64603	45.4683
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
sc=0.41102;fc=70.1685;
sd=0.773694;fd=70.1727;
sb= 4.82592;fb=70.2794;
sa=0.00483559;fa=45.4254;
sg=3.64603;fg=45.4683;
jiao=atan(abs((fc-fb)/(sc-sb)));
db=abs((sb-sd)/cos(jiao));
cb=abs((sb-sc)/cos(jiao));
ag=abs((sa-sg)/cos(jiao));
pru=0.2+rou*Q(i)*g/Ap/1440/10/10^6;
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
rz=abs(2*deta*ksai-1);
rt=abs(2*deta*yitak-1);
if rz>1
    rz=1;
end
if rt>1
    rt=1;
end
tad=acos(rz)/w;
tdb=acos(-rz)/w;
tbg=acos(rt)/w;
arfa=(1-ksai)*(1-b)*(tad+tdb+tbg)/tdb;

tbg=acos(rt)/w;
tga=acos(-rt)/w;
tac=acos(rz)/w;
beta=(ksai-1)*(1-b)*(tbg+tga+tac)/tga;
if flag==1
    Ql=1440*Spe*N*(yita-arfa)*pi*D^2/4;
else if flag==0
    Ql=1440*Spe*N*(yita-beta)*pi*D^2/4;
    end
end
end
Ql
    




