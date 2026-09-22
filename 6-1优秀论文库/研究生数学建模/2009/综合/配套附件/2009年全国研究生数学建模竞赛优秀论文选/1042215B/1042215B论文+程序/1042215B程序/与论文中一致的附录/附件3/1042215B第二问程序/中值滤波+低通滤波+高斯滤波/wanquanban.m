
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%产生一个xz轴平面
load F:\建模\题\6x2次棱数据\77T1-1203959\c1.dat
%size(c1)


i=1:564;      %x轴点的个数。
x=zeros(1,564);
x(i)=0:0.00275:1.54825;
for i=1:564
    
    z(i)=c1((564*249)+i,3);
end
figure(2)
plot(x,z)
xlabel('x轴的值');ylabel('z轴的初始值');title('xoz平面截面图');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%进行中值滤波
zz=medianfun(z,5);
figure(3)
plot(x,zz)
xlabel('x轴的值');ylabel('中值滤波后z轴的值');title('xoz平面截面图');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%设计低通滤波器
Fs=363;
[b,a]=butter(9,100/363,'low');
[H,w]=freqz(b,a,512);
figure(4)
plot(w*Fs/(2*pi),abs(H));

xlabel('w');ylabel('低通滤波器的频率响应');title('低通滤波器');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%信号进行滤波
sf=filter(b,a,zz);
figure(5)
plot(x,sf);
xlabel('x轴的值');ylabel('低通滤波后z轴的值');title('xoz平面截面图');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%进行高斯滤波
yy=filter(gaussfiltcoef(363,20),1,sf);
figure(6)
plot(x,yy);
xlabel('x轴的值');ylabel('高斯滤波后z轴的值');title('xoz平面截面图');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(7)   %对于滤波后加入的新的误差

x1=x(40:524);
yyy=yy(40:524);
plot(x1,yyy);
xlabel('x轴的值');ylabel('滤除新误差后z轴的值');title('xoz平面截面图');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%看前后频谱图
S=fft(z,512);
SF=fft(yy,512);
w1=(0:255)/256*(Fs/2);
figure(8)
subplot(1,2,1)
plot(w1,abs(S(1:256)));
xlabel('w1');ylabel('初始离散z值的频率响应');
subplot(1,2,2)
plot(w1,abs(SF(1:256)));
xlabel('w1');ylabel('经滤波后离散z值的频率响应');