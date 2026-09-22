function [xc fc]=bijiao3()

global para;
q1=para(1)/2700;q2=para(1)/10800;q3=para(2)/7200;
s1=para(3)/2700;s2=para(3)/10800;s3=para(4)/7200;

y=q1/s1+q2/s2+q3/s3;
T=27.5/(1-y);
g1=q1/s1/y*(T-15);
g2=q2/s2/y*(T-15);
g3=q3/s3/y*(T-15);
xc=zeros(4,1);
xc(1)=g1/T;xc(2)=g2/T;xc(3)=g3/T;xc(4)=T;
fc=fbfun3(xc);
xc=[xc(1);xc(2);xc(3);0;xc(4)];