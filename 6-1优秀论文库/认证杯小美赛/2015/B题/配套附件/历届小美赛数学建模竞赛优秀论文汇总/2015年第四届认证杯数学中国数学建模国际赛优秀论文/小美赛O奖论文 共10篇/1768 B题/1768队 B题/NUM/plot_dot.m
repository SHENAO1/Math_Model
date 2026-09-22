clear; %热力分布
load dot_stop.mat;

x = -(90+dot_stop(1,:)).*cos( dot_stop(2,:)*pi/180 )*10.5+338;
y = (90+dot_stop(1,:)).*sin( dot_stop(2,:)*pi/180 )*10.5+337;
t = -[23.4 52.3 23.6 32.6 33.6 43.4 52.3 43.4 52.3 25.6 32.6 43.6 65.3 52.3...
    25.6 32.6 43.6 23.4 52.3...
    23.6 32.6 33.6 43.4 52.3 46.8 25.6 32.6 43.6 52.3 25.6 32.6 43.6...
    23.6 32.6 33.6 43.4 52.3 25.6 32.6 43.6 52.3 65.3 52.3 25.6 32.6 43.6];
figure(1);
scatter(x,y,6,t);
hold on;
[X,Y,T] = griddata(x,y,t,linspace(min(x),max(x)),linspace(min(y),max(y))','v4');
pcolor(X,Y,T);
shading interp;
scatter(x,y,40,t,'black');

