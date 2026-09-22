function [c,ceq]=confun3(x)

global para;
global gmin;
q1=para(1)/2700;q2=para(1)/10800;q3=para(2)/7200;
s1=para(3)/2700;s2=para(3)/10800;s3=para(4)/7200;
bh1=q1/s1/x(1);bh2=q2/s2/x(2);bh3=q3/s3/x(3);
gmin=10;

c=[gmin-x(1)*x(4);gmin-x(2)*x(4);gmin-x(3)*x(4);bh1-0.9;0.7-bh1;bh2-0.9;0.7-bh2;bh3-0.9;0.7-bh3];
ceq=[x(1)+x(2)+x(3)+15/x(4)-1];