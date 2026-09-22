function [xps1 fps1 xps2 fps2 xps3 fps3]=poisson_fb4(paraz)
global para;
global Tst;
para=paraz;
[x1 fval1]=fb4(para);
Tst=x1(5);
xps1=[];fps1=[];xps2=[];fps2=[];xps3=[];fps3=[];
for i=1:10
   fval1=fbfun4(x1);
   [x2 fval2]=fbt4(para);
   [x3 fval3]=fb4(para);
   xps1=[xps1 x1];
   fps1=[fps1 fval1];
   xps2=[xps2 x2];
   fps2=[fps2 fval2];
   xps3=[xps3 x3];
   fps3=[fps3 fval3];
   
   Tw=(1-x3([1,3])).*x3(5);  %1st and 3rd phase's waiting time
   lambda=(para(1:2))'.*Tw/3600;
   Q=[poissrnd(lambda(1)) poissrnd(lambda(2))];
   while max(max(Q))>=18|min(min(Q))<=8
   Q=[poissrnd(lambda(1)) poissrnd(lambda(2))];
   end
   para=[Q./Tw'*3600 8000 4000];
   
end