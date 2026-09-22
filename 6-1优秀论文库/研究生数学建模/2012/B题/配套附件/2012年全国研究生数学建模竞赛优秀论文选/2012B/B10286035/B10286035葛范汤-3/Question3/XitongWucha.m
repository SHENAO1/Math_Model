%load('satellite06_RK78.mat')
% load('satellite09_RK78.mat')

load('satellite06_50_1812_170.mat')
load('satellite09_50_1812_170.mat')

load('yy_0600_fa.mat')
%load('yy_0600_beta.mat')

load('meadata_09_00.mat')

NUM = 600;
PI=3.1415926;
Xsat06 = satellite06_50_1812_170(1:NUM,1); % 600*1
Xsat09 = satellite09_50_1812_170(1:NUM,1);

Ysat06 = satellite06_50_1812_170(1:NUM,2);
Ysat09 = satellite09_50_1812_170(1:NUM,2);

Zsat06 = satellite06_50_1812_170(1:NUM,3);
Zsat09 = satellite09_50_1812_170(1:NUM,3);

alfa06 = yy_0600_fa(1:NUM, 2);      % 600*1
beta06 = yy_0600_fa(1:NUM, 2);

alfa09 = meadata_09_00(1:NUM, 2);
beta09 = meadata_09_00(1:NUM, 3);

deltaT = 0.2;
PM=0;
dPM=0;
ddPM=0;
T06=0;%×ªÒÆ¾ØÕó
Zuiyouangle=0;
tempWucha=100000000000000000;
for j=1:700
    T06=[cos(PI*j/18000) -sin(PI*j/18000) 0;sin(PI*j/18000) cos(PI*j/18000) 0;0 0 0];
    

for i=1:NUM
    T3cs06 = T06*Trans3CS([Xsat06(i); Ysat06(i); Zsat06(i)]);
    T3cs09 = Trans3CS([Xsat09(i); Ysat09(i); Zsat09(i)]);
    
    coef06 = T3cs06*[1; alfa06(i); beta06(i)];  % 3*1
    coef09 = T3cs09*[1; alfa09(i); beta09(i)];
    
    deltaX = Xsat06(i) - Xsat09(i);
    deltaY = Ysat06(i) - Ysat09(i);
    deltaZ = Zsat06(i) - Zsat09(i);
    det=[deltaX;deltaY;deltaZ];
    
    
    % func 1
   mat_func1 = [-coef06(1) coef09(1); -coef06(2) coef09(2)];
   temp = inv(mat_func1)*[deltaX; deltaY];
   t09_func1 = temp(2);
   xm_func1 = Xsat09(i) + t09_func1*coef09(1);
   ym_func1 = Ysat09(i) + t09_func1*coef09(2);
   zm_func1 = Zsat09(i) + t09_func1*coef09(3);
   % func 2
   mat_func2 = [-coef06(1) coef09(1); -coef06(3) coef09(3)];
   temp = inv(mat_func2)*[deltaX; deltaZ];
   t09_func2 = temp(2);
   xm_func2 = Xsat09(i) + t09_func2*coef09(1);
   ym_func2 = Ysat09(i) + t09_func2*coef09(2);
   zm_func2 = Zsat09(i) + t09_func2*coef09(3);
   
%     
    xm = (xm_func1 + xm_func2)/2;
    ym = (ym_func1 + ym_func2)/2;
    zm = (zm_func1 + zm_func2)/2;
    
    PM1(i,1:3) = [xm ym zm];
   
    
end
 if(GetWucha(PM1)<tempWucha)
     tempWucha=GetWucha(PM1);
     Zuiyouangle=j*0.1;
     
 end
end
tempWucha
Zuiyouangle
% % func 1
% t09_func1 = ( alfa06.*(Xsat06 - Xsat09) - (Ysat06 - Ysat09) )./ (alfa06-alfa09);
% xm_func1 = Xsat09 + t09_func1;
% ym_func1 = Ysat09 + t09_func1.*alfa09;
% zm_func1 = Zsat09 + t09_func1.*beta09;
% 
% % func 2
% t09_func2 = ( beta06.*(Xsat06 - Xsat09) - (Zsat06 - Zsat09) )./ (beta06-beta09);
% xm_func2 = Xsat09 + t09_func2;
% ym_func2 = Ysat09 + t09_func2.*alfa09;
% zm_func2 = Zsat09 + t09_func2.*beta09;
% 
% xm = (xm_func1 + xm_func2)/2;
% ym = (ym_func1 + ym_func2)/2;
% zm = (zm_func1 + zm_func2)/2;
% 
% PM = [xm ym zm];

target_step1 = PM;
d_target_step1 = dPM;
dd_target_step1 = ddPM;
save target_step1 target_step1 d_target_step1 dd_target_step1;

%plot3( PM(:,1), PM(:,2), PM(:,3),'r','Linewidth', 2 );
hold on
plot3(Xsat06, Ysat06, Zsat06,'g','Linewidth', 2);
plot3(Xsat09, Ysat09, Zsat09,'g','Linewidth', 2);
% plot3( satellite06_RK78(:,1), satellite06_RK78(:,2), satellite06_RK78(:,3),'b' );
% plot3( satellite09_RK78(:,1), satellite09_RK78(:,2), satellite09_RK78(:,3),'b' );

[XE, YE, ZE] = sphere(10);
RE = 0.64e7;
XE = RE*XE;
YE = RE*YE;
ZE = RE*ZE;
mesh(XE, YE, ZE)
grid on 
axis equal

GM=3.986005e14;
% for i=1:600
%     moPM(i) = sqrt(sum(PM(i,:).^2));
% end
% test = GM./moPM.^3;