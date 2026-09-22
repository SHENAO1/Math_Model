load F:\建模\题\6x2次棱数据\77T1-1203959\c1.dat
size(c1)


i=1:564;      %x轴点的个数。
x(i)=0:0.00275:1.54825;
for i=1:564
    
    z(i)=c1((564*249)+i,3);
end
%figure(1)
%plot(x,z)

%y=filter(gaussfiltcoef(363,20),1,z);
%figure(2)
%plot(x,y)
y=wden(z,'heursure','s','mln',5,'sym8');  %小波变换 作用范围对高斯噪声起的效果较大
figure(1)
subplot(1,2,1)
plot(x,z)
xlabel('x轴的值');ylabel('z轴的初始值');title('XOZ平面截面图');
subplot(1,2,2)
plot(x,y)
xlabel('x轴的值');ylabel('小波滤波后z轴的值');title('XOZ平面截面图');