%第一问的地球及09号观测卫星的轨迹图
function earthface(Dtheta)
if nargin==0
  Dtheta=15;
end
R=6400000;
fai=(-180:Dtheta:180)*pi/180;
theta=(-90:Dtheta:90)*pi/180;
X1=R*cos(theta)'*cos(fai);
Y1=R*cos(theta)'*sin(fai);
Z1=R*sin(theta)'*ones(size(fai));
colormap([0 0 1])
mesh(X1,Y1,Z1)
hold on 
[X,Y]=ode45('fun',[0,9000],[2043922.166765    -5379.544693     8186504.631471   -407.095342    4343461.714791     3516.052656]);
[X2,Y2]=ode45('fun',[0,250],[2043922.166765    -5379.544693     8186504.631471   -407.095342    4343461.714791     3516.052656]);
 plot3(Y(10:end,1),Y(10:end,3),Y(10:end,5),'r-.','LineWidth',1),hold on
 plot3(Y2(:,1),Y2(:,3),Y2(:,5),'b','LineWidth',2.5)
 
 

    


