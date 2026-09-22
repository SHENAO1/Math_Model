function F=myfun(x,xdata)
 load('td_data');  
 load('ydata');  
for i=1:599
    sub_temp1=x(1)-x(2)*xdata(i);
    sub_temp2=sqrt(((norm(ydata(:,i)))^2)*(x(1)-x(2)*xdata(i))^2/x(2)^2);
    F(i)=sub_temp1-x(1)*exp(-(norm(td_data(i,4:6))-(norm(td_data(1,4:6))))/sub_temp2);
end

