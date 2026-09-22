function [c,ceq]=confun4(x)

global para;
global gmin;
q1=para(1)/3600;q2=para(1)/7200;q3=para(2)/3600;q4=para(2)/7200;
s1=para(3)/3600;s2=para(3)/7200;s3=para(4)/3600;s4=para(4)/7200;
bh1=q1/s1/x(1);bh2=q2/s2/x(2);bh3=q3/s3/x(3);bh4=q4/s4/x(4);
gmin=10;

c=[gmin-x(1)*x(5);gmin-x(2)*x(5);gmin-x(3)*x(5);gmin-x(4)*x(5);bh1-0.9;0.7-bh1;bh2-0.9;0.7-bh2;bh3-0.9;0.7-bh3;bh4-0.9;0.7-bh4];
ceq=[x(1)+x(2)+x(3)+x(4)+20/x(5)-1];