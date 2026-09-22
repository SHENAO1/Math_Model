load('target_step1')

NUM = 600;
xm = target_step1(:,1);
ym = target_step1(:,2);
zm = target_step1(:,3);

scatter3(xm,ym,zm,'filled')
hold on
X = [ones(size(xm)) xm ym];
b = regress(zm,X);

jiange = 1000;
xfit = min(xm):jiange:max(xm); %注 100表示数据的间隔
yfit = min(ym):jiange:max(ym);
[XFIT,YFIT]= meshgrid (xfit,yfit); %制成网格数据
ZFIT = b(1) + b(2) * XFIT + b(3) * YFIT;
mesh (XFIT,YFIT,ZFIT)

XX=0;
YY=0;
ZZ=b(1) + b(2) * XX + b(3) * YY;
% plot3(XX, YY, ZZ, '-mo',...
%                 'LineWidth',2,...
%                 'MarkerEdgeColor','k',...
%                 'MarkerFaceColor',[.49 1 .63],...
%                 'MarkerSize',10)

deltaT = 0.2;
PM_ploy=0;
dPM_ploy=0;
ddPM_ploy=0;
xpoly=0;
ypoly=0;
zpoly=0;
for i=1:NUM
    t = -(b(2)*xm(i)+b(3)*ym(i)+(-1)*zm(i)+b(1))/(b(2)^2+b(3)^2+1^2);
    xpoly(i) = xm(i)+b(2)*t;
    ypoly(i) = ym(i)+b(3)*t;
    zpoly(i) = zm(i)+(-1)*t;
    
    PM_ploy(i,1:3) = [xpoly(i) ypoly(i) zpoly(i)];
    if i>1
        dPM_ploy(i,1:3) = (PM_ploy(i,1:3)-PM_ploy(i-1,1:3))/deltaT;
    end
    if i>2
        ddPM_ploy(i,1:3) = (dPM_ploy(i,1:3)-dPM_ploy(i-1,1:3))/deltaT;
    end
end
save PM_ploy PM_ploy;
save dPM_ploy dPM_ploy;
save ddPM_ploy ddPM_ploy;
plot3(xpoly, ypoly, zpoly, 'r', 'Linewidth', 2);
