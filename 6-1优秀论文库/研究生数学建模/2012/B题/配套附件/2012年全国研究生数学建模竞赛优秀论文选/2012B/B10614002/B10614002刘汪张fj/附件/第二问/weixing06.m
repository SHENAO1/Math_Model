%求06号观测卫星在09号时间点上的alpha、beta插值
load meadata_09_00.txt
load meadata_06_00.txt
x=meadata_09_00(:,1);
y=spline(meadata_06_00(:,1),meadata_06_00(:,2),x);
z=spline(meadata_06_00(:,1),meadata_06_00(:,3),x);
x=x';
y=y';
z=z';









