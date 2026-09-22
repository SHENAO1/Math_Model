function [Fu,Fd,S]=FP(xx,yy,a)%利用功图积分计算平均载荷
%a表示前a个点为上冲程的点
k=length(xx);
Fu=0;
Fd=0;
for i=1:a
    Fu=Fu+(yy(i)+yy(i+1))/2*(xx(i+1)-xx(i));
end 
for i=a+1:k-1
    Fd=Fd+(yy(i)+yy(i+1))/2*(xx(i)-xx(i+1));
end
Fu=Fu/(xx(a)-xx(1));
Fd=Fd/(xx(a)-xx(k));
S=xx(a)-xx(1);
end
