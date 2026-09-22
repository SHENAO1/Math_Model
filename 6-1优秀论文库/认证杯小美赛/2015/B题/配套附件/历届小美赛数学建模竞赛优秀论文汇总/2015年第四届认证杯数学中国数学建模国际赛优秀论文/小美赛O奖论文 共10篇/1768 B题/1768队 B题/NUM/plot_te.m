clear;   %南极地图加点

% xa = -2:0.2:2;
% ya = xa;
% [x,y] = meshgrid(xa,ya);
% z = x.*exp(-x.^2 - y.^2);
% mesh(x,y,z);
figure(2);
im = imread('blank_line.bmp');
imshow(im);
hold on;
load dot_stop.mat

T = -[23.4 52.3 23.6 32.6 33.6 43.4 52.3 43.4 52.3 25.6 32.6 43.6 65.3 52.3...
    25.6 32.6 43.6 23.4 52.3...
    23.6 32.6 33.6 43.4 52.3 46.8 25.6 32.6 43.6 52.3 25.6 32.6 43.6...
    23.6 32.6 33.6 43.4 52.3 25.6 32.6 43.6 52.3 65.3 52.3 25.6 32.6 43.6];

x = -(90+dot_stop(1,:)).*cos( dot_stop(2,:)*pi/180 )*10.5+338;
y = -(90+dot_stop(1,:)).*sin( dot_stop(2,:)*pi/180 )*10.5+337;

figure(2);
scatter(x,y,200,T,'.','r');

% figure(2);
% [X,Y,T] = griddata(x,y,T,linspace(min(x),max(x)),linspace(min(y),max(y))','v4');
% pcolor(X,Y,T);
% shading interp;

