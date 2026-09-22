%lsqcurvefit拟合范例
clear all
load('td_data');
data06_00=textread('meadata_06_00.txt');
xdata = data06_00(1:599,1);
xdata=xdata';
gm=3.986005*10^14;
for i=1:599
    ydata(1,i)=td_data(i,7)+(gm*td_data(i,1)/(td_data(i,1)^2+...
        td_data(i,2)^2+td_data(i,3)^2)); %某时刻位置矢量的模  x轴
    ydata(2,i)=td_data(i,8)+(gm*td_data(i,2)/(td_data(i,1)^2+...
        td_data(i,2)^2+td_data(i,3)^2)); %某时刻位置矢量的模  y轴
    ydata(3,i)=td_data(i,9)+(gm*td_data(i,3)/(td_data(i,1)^2+...
        td_data(i,2)^2+td_data(i,3)^2)); %某时刻位置矢量的模  z轴
end
x0 = [50000,0.4];   % Starting guess
%ydata=ydata';
[x,resnorm] = lsqcurvefit(@myfun,x0,xdata,ydata(1,:));
%subplot(3,1,1)
plot(xdata,ydata(1,:),'ko')
hold on
