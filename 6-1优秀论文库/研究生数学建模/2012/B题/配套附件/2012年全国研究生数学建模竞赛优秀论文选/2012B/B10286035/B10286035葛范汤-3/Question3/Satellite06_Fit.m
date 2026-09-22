format long ;
load('meadata_06_00.mat')
load('meadata_09_00.mat')

% plot(meadata_06_00(:,1), meadata_06_00(:,2),'.')

%xx = meadata_09_00(:,1);

%yy_0600_alfa = interp1(meadata_06_00(:,1), meadata_06_00(:,2), xx, 'spline');      % 三次样条插值
%yy_0600_beta = interp1(meadata_06_00(:,1), meadata_06_00(:,3), xx, 'spline');      % 三次样条插值

% xx = meadata_06_00(1,1):0.005774101993:meadata_06_00(600,1);
% yy_0600_alfa = spline(meadata_06_00(:,1), meadata_06_00(:,2), xx);  % 三次样条插值
% yy_0600_beta = spline(meadata_06_00(:,1), meadata_06_00(:,3), xx);

% plot(xx, yy_0600_alfa,'.')
% hold on
% plot(meadata_06_00(:,1), meadata_06_00(:,2),'.r')
% 
% plot(xx, yy_0600_beta,'.')
% hold on
% plot(meadata_06_00(:,1), meadata_06_00(:,3),'.r')
xx = meadata_06_00(:,1);
ya = meadata_06_00(:,2);
yb = meadata_06_00(:,3);
p1=polyfit (xx,ya,6);
p2=polyfit(xx,yb,6);
NUM=600;
yy_0600_fa=0;
% 
% for i=1:NUM
%    yy_0600_alfa( i,1:3)=p1(:,1)*meadata_09_00(
% 
% end;
 for i=1:NUM
     xa= Trans(p1,meadata_09_00(i,1));
     xb=Trans(p2,meadata_09_00(i,1));
yy_0600_fa(i,1:3)=[ meadata_09_00(i,1) xa xb];

 end;
 save yy_0600_fa yy_0600_fa;