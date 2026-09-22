function [xc fc]=bijiao()

global para;
q1=para(1)/3600;q2=para(1)/7200;q3=para(2)/3600;q4=para(2)/7200;
s1=para(3)/3600;s2=para(3)/7200;s3=para(4)/3600;s4=para(4)/7200;

y=q1/s1+q2/s2+q3/s3+q4/s4;
T=35/(1-y);
g1=q1/s1/y*(T-20);
g2=q2/s2/y*(T-20);
g3=q3/s3/y*(T-20);
g4=q4/s4/y*(T-20);
xc=zeros(5,1);
xc(1)=g1/T;xc(2)=g2/T;xc(3)=g3/T;xc(4)=g4/T;xc(5)=T;
fc=fbfun4(xc);