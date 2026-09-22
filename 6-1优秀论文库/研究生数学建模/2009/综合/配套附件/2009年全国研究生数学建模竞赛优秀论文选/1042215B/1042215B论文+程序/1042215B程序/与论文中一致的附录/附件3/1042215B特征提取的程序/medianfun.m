%中值滤波函数
%实现方法：
%　　1：通过从图像中的某个采样窗口取出奇数个数据进行排序
%　  2：用排序后的中值取代要处理的数据即可


function [y]=median(x,a)  %a=5  x输入为行向量
   N=length(x);            
   b=(a-1)/2;
   y=zeros(N,1);
   temp=zeros(N+4);
   x1=zeros(N);
   x2=zeros(N);
   x1(1:2)=0;
   x1(N+3:N+4)=0;
   x1(3:N+2)=x;
   for i=3:N+2
       temp=x1(i-b:i+b);
       tempsort=sort(temp);
       x2(i)=tempsort(b+1);
   end
   y(1:N)=x2(3:N+2);
   y=y';
   
   
   
       
       
   