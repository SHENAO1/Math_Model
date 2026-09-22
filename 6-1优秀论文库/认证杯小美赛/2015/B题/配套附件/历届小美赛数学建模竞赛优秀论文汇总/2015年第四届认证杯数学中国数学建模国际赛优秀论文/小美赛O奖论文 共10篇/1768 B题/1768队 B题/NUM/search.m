clear;
% 
% T = -[23.4 52.3 23.6 32.6 33.6 43.4 52.3 43.4 52.3 25.6 32.6 43.6 65.3 52.3...
%     25.6 32.6 43.6 23.4 52.3...
%     23.6 32.6 33.6 43.4 52.3 46.8 25.6 32.6 43.6 52.3 25.6 32.6 43.6...
%     23.6 32.6 33.6 43.4 52.3 25.6 32.6 43.6 52.3 65.3 52.3 25.6 32.6 43.6];
figure(1);
load dot_stop.mat
x=[1:1:12];
y=[1:1:5];
z=[0.2 0.24 0.25 0.26 0.25 0.25 0.25 0.26 0.26 0.29 0.25 0.29;
0.27 0.31 0.3 0.3 0.26 0.28 0.29 0.26 0.26 0.26 0.26 0.29;
0.41 0.41 0.37 0.37 0.38 0.35 0.34 0.35 0.35 0.34 0.35 0.35;
0.41 0.42 0.42 0.41 0.4 0.39 0.39 0.38 0.36 0.36 0.36 0.36;
0.3 0.36 0.4 0.43 0.45 0.45 0.51 0.42 0.4 0.37 0.37 0.37];
surf(x,y,z)
title('Original data Plot');
xlabel('X'), ylabel('Y'), zlabel('Z'),
colormap, colorbar;
axis([0 15 0 6 0.15 0.55]);

x1=1:0.2:12;
y1=1:0.2:5;
[x2,y2]=meshgrid(x1,y1);
t11=interp2(x,y,z,x2,y2,'cubic');
surf(x1,y1,t11)
title('After Fit data Plot');
xlabel('X'), ylabel('Y'), zlabel('Z'),
colormap, colorbar;
shading interp;

% figure(2);
% ky = 3; knotsy = augknt([0:2.5:13],ky);
% sp = spap2(knotsy,ky,y,z);
% yy = 0:.5:12; vals = fnval(sp,yy);
% coefsy = fnbrk(sp,'c');
% kx = 5; knotsx = augknt([1:4:5],kx);
% sp2 = spap2(knotsx,kx,x,coefsy.');
% coefs = fnbrk(sp2,'c').';
% xv = 1:.25:5; yv = 1:.5:12;
% values = spcol(knotsx,kx,xv)*coefs*spcol(knotsy,ky,yv).';
% surf(yv,xv,values)
% title('After Polynal data Plot');
% xlabel('X'), ylabel('Y'), zlabel('Z');
% colormap, colorbar;
% axis([0 15 0 6 0.2 0.55]);


