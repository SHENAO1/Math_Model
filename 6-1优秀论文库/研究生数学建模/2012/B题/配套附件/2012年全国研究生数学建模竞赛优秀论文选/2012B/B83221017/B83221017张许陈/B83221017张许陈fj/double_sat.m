function double_sat()
clc;clear all;
%% 读取数据
global startt endt  interval;
startt = 50;endt = 170;interval=0.1;
data06_00 = importdata('meadata_06_00.txt');
data09_00 = importdata('meadata_09_00.txt');
t = [startt:interval:endt]';

%% 插值获取06号卫星对00号飞行器的alpha，beta值
s1t = data06_00(:,1); % 卫星6接收数据的时刻
s1alpha = data06_00(:,2); 
s1beta = data06_00(:,3);
% 卫星插值得到的alpha，需要外推插值
alpha1 = interp1(s1t, s1alpha, t, 'spline', 'extrap'); 
beta1 = interp1(s1t, s1beta, t, 'spline', 'extrap');

%% 插值获取09号卫星对00号飞行器的alpha，beta值
s2t = data09_00(:,1);
s2alpha = data09_00(:,2);
s2beta = data09_00(:,3);
% 卫星插值得到的alpha
alpha2 = interp1(s2t, s2alpha, t, 'spline', 'extrap'); 
beta2 = interp1(s2t, s2beta, t, 'spline', 'extrap');

%% 获取卫星的实时位置
front = [0:interval:startt-interval]';
back = [(endt+interval):interval:2000]';
mid = [startt:interval:endt]';
ss1 = sat_moving(6, [front; mid; back]); % 卫星的轨迹，0.1秒为间隔
ss2 = sat_moving(9, [front; mid; back]);
global s1 s2;
s1 = ss1(size(front,1)+1:size([front;mid],1),:); % 取出50到170秒的数据
s2 = ss2(size(front,1)+1:size([front;mid],1),:);

%% 格式输出数据
% disp(num2str(ss2(501,:), '%10.5e'));
% disp(num2str(ss2(1001,:), '%10.5e'));
% disp(num2str(ss2(1501,:), '%10.5e'));
% disp(num2str(ss2(2001,:), '%10.5e'));
% disp(num2str(ss2(2501,:), '%10.5e'));

%% 根据交点拟合出轨道
global crtgt;
crtgt = zeros(size(t,1),9);
crtgt(:,1:3) = cross_tgt(t, s1, s2, alpha1, beta1, alpha2, beta2);
crtgt(:,4:9) = get_tgtva(t, crtgt(:,1:3));

%% 参数估计
global para;
options = gaoptimset('Display', 'iter', 'InitialPopulation', [2000 -500 crtgt(1,4) crtgt(1,5)  crtgt(1,6)]);
% 利用遗传算法， 同时对模型参数和速度初值进行估计，速度使用曲线拟合出来，故存在偏差，在一定范围内取值
[para, fval, exitflag] = ga(@compare_tgt_line, 5, [],[],[],[],...
  [1000 -1000 crtgt(1,4)-30 crtgt(1,5)-30  crtgt(1,6)-30 ], [4000 -171 crtgt(1,4)+30 crtgt(1,5)+30  crtgt(1,6)+30], [], options);
%para=[3359.20068777921,-190.364625348910,-820.956500638111,760.004685720828,945.938683360771;];

%% 用估计的参数代入模型重新求解弹道
ytgt = tgt_moving(para);
fprintf('估计轨道曲线残差为%10.5f\n', compare_tgt_line(para));

%% 求系统误差
[dalpha1 dbeta1 dtheta1] = get_sys_err(s1, ytgt, crtgt);
fprintf(1,'卫星6的系统误差为dalpha=%10.5e,dbeta=%10.5e,dtheta=%10.5e\n',dalpha1,dbeta1,dtheta1);
[dalpha2 dbeta2 dtheta2] = get_sys_err(s2, ytgt, crtgt);
fprintf(1,'卫星9的系统误差为dalpha=%10.5e,dbeta=%10.5e,dtheta=%10.5e\n',dalpha2,dbeta2,dtheta2);

%% 抛去系统误差，重新拟合弹道
if 1
[alpha1f beta1f] =  remove_sys_err(dalpha1,dbeta1,dtheta1, alpha1, beta1);
[alpha2f beta2f] =  remove_sys_err(dalpha2,dbeta2,dtheta2, alpha2, beta2);
crtgt = zeros(size(t,1),9);
crtgt(:,1:3) = cross_tgt(t, s1, s2, alpha1f, beta1f, alpha2f, beta2f);
crtgt(:,4:9) = get_tgtva(t, crtgt(:,1:3));
options = gaoptimset('Display', 'iter', 'InitialPopulation', [2000 -500 crtgt(1,4) crtgt(1,5)  crtgt(1,6)]);
% 利用遗传算法， 同时对模型参数和速度初值进行估计，速度使用曲线拟合出来，故存在偏差，在一定范围内取值
[para, fval, exitflag] = ga(@compare_tgt_line, 5, [],[],[],[],...
  [1000 -1000 crtgt(1,4)-50 crtgt(1,5)-50  crtgt(1,6)-50 ], [4000 -171 crtgt(1,4)+50 crtgt(1,5)+50  crtgt(1,6)+50], [], options);
%para = [3999.47010444527,-205.785902991137,-828.741046488494,724.472728561852,925.110741189379;];
ytgt = tgt_moving(para);
fprintf('去除系统误差后估计轨道曲线残差为%10.5f\n', compare_tgt_line(para));
end

% 抽样输出
fid = fopen('tgt00.txt','w');
for i = 1:100:1201
fprintf(fid,'%3d\t%10.5e\t%10.5e\t%10.5e\t%10.5e\t%10.5e\t%10.5e\r\n',t(i), ytgt(i,:));
end
fclose(fid);

%% 画图
%paint_tgt(t,crtgt); % 画交汇拟合弹道和模型估计弹道的各种位置、速度、加速度曲线，弹窗较多
%paint_tgt(t,ytgt); % 画模型拟合弹道和模型估计弹道的各种位置、速度、加速度曲线，弹窗较多
figure;
plot3(ytgt(1:end,1),ytgt(1:end,2),ytgt(1:end,3),'black');
hold on;
plot3(crtgt(:,1),crtgt(:,2), crtgt(:,3));
% plot3(ss1(1:500:end,1),ss1(1:500:end,2), ss1(1:500:end,3), '.g');
% plot3(ss2(1:500:end,1),ss2(1:500:end,2), ss2(1:500:end,3), '.-r');
legend('根据交汇数据拟合曲线','交汇轨道');
%legend('建模轨道','交汇轨道','6号卫星','9号卫星');
xlabel('x');
ylabel('y');
zlabel('z');
grid on;
end 

%% 解两个射线联立的方程组，求交点
function tgt = cross_tgt(t, s1,s2,alpha1,beta1,alpha2,beta2)
tgt = zeros(size(t,1), 3);
for it = 1:size(t,1)
    xs1 = s1(it,1); ys1 = s1(it,2); zs1 = s1(it,3); % 卫星6当前xyz
    xs2 = s2(it,1); ys2 = s2(it,2); zs2 = s2(it,3); % 卫星9当前xyz
    c1 = CU2E(xs1, ys1, zs1)*[1; alpha1(it); beta1(it)];
    c2 = CU2E(xs2, ys2, zs2)*[1; alpha2(it); beta2(it)];
    l1 = c1(1); m1 = c1(2); n1 = c1(3); 
    l2 = c2(1); m2 = c2(2); n2 = c2(3);
    deltx = xs1 - xs2;delty = ys1 - ys2;deltz = zs1 - zs2;
    q = (deltx*(m1-n1)+delty*(n1-l1)+deltz*(l1-m1))/(l2*(m1-n1)+m2*(n1-l1)+n2*(l1-m1));
    p = (q*(m2-n2)-delty+deltz)/(m1-n1);
    tgt11 = xs1 + p*l1;
    tgt21 = ys1 + p*m1;
    tgt31 = zs1 + p*n1;
    tgt12 = xs2 + q*l2;
    tgt22 = ys2 + q*m2;
    tgt32 = zs2 + q*n2;
    tgt1 = (tgt11 + tgt12)/2;
    tgt2 = (tgt21 + tgt22)/2;
    tgt3 = (tgt31 + tgt32)/2;
    tgt(it, 1:3) = [tgt1; tgt2; tgt3;];
end
end

%% 拟合弹道的多项式曲线，以便求速度、加速度
function tgtva = get_tgtva(t, tgtr)
px = polyfit(t,tgtr(:,1),3);
py = polyfit(t,tgtr(:,2),3);
pz = polyfit(t,tgtr(:,3),3);
% 根据拟合曲线，求速度加速度
%代入多项式的一次导求速度
tgtva(:,1) = 3.*px(1).*t.^2+2.*px(2).*t+px(3);
tgtva(:,2) = 3.*py(1).*t.^2+2.*py(2).*t+py(3);
tgtva(:,3) = 3.*pz(1).*t.^2+2.*pz(2).*t+pz(3);
% 代入多项式的两次导求加速度
tgtva(:,4) = 6.*px(1).*t+2.*px(2);
tgtva(:,5) = 6.*py(1).*t+2.*py(2);
tgtva(:,6) = 6.*pz(1).*t+2.*pz(2);
end

%% 目标函数
function f = compare_tgt_line(k)
global crtgt;
y1 = tgt_moving(k);
d = y1 - crtgt(:,1:6);
f = sqrt(sum(sum(d(:,1:3).^2))/(size(d,1)*3));
end

%% 目标的运动方程积分
function ys = tgt_moving(k)
global crtgt  startt  endt  interval;
tspan = startt:interval:endt;
% k1: vr k2:m0/mdot k3:vx k4:vy k5:vz
y0 = ([crtgt(1,1:3) k(3:5)])';
[tt, Y] = ode45(@(t, y) tgt(t,y,k), tspan, y0);
ys =Y;
end

%% 微分方程函数
function  dydt = tgt( t, y, k)
% k(1): vr
% k(2): m0/mdot
% y = [r; rdot]
% dydt = [rdot; rdotdot;]
Gm = 3.986005e14;
dydt = zeros(6,1);
dydt(1:3) = y(4:6);
dydt(4:6) = - (Gm./((sqrt(y(1)^2+y(2)^2+y(3)^2))^3)).*[y(1);y(2);y(3) ] - (k(1)/(k(2)+t)).*[y(4);y(5);y(6)]/sqrt(y(4)^2+y(5)^2+y(6)^2);
end

%% 计算系统误差
function [dalpha dbeta dtheta ] = get_sys_err(s, tgt, crtgt)
% s卫星的位置，tgt为用拟合模型求出来的弹道，alpha0、beta0为初始给定，用于比较
dabc = zeros(size(s,1),3);
for i = 1:size(s,1)
    m = CU2E(s(i,1),s(i,2),s(i,3))'*((tgt(i,1:3) - s(i,1:3))'); % 卫星坐标系下的目标矢量
    n = CU2E(s(i,1),s(i,2),s(i,3))'*((crtgt(i,1:3) - s(i,1:3))'); % 卫星坐标系下的目标矢量
    if m == n
        dabc(i,:) = 0;
    else
        dr =  cross(m,n)/norm(cross(m,n));
        dr = dr*acos(dot(m,n)/(norm(m)*norm(n)));
        dabc(i,:) = dr;
    end
end
% 求均值
d = mean(dabc);
dalpha = d(1); dbeta = d(2); dtheta=d(3);
end

%% 对给出的alpha beta去除系统误差
function [alpha beta] = remove_sys_err(dalpha,dbeta,dtheta, alpha0, beta0)
alpha=zeros(size(alpha0,1),1);
beta=zeros(size(beta0,1),1);
for i = 1:size(alpha0)
    rz = [cos(-dalpha) sin(-dalpha) 0; -sin(-dalpha) cos(-dalpha) 0; 0 0 1];
    ry = [cos(-dbeta) 0 -sin(-dbeta); 0 1 0;sin(-dbeta) 0 cos(-dbeta)];
    rx = [1 0 0; 0 cos(-dtheta) sin(-dtheta); 0 -sin(-dtheta) cos(-dtheta)];
    dd = rx*ry*rz*[1;alpha0(i);beta0(i)];
    alpha(i,1) = dd(2)/dd(1);
    beta(i,1) = dd(3)/dd(1);
end
end

function paint_tgt(t,tgt)
%% 画图
%交汇出来的曲线
figure;
plot(t,tgt(:,1));
xlabel('时间t(s)');ylabel('x(m)');
title('位置x-时间曲线');
grid on;
figure;
plot(t,tgt(:,2));
xlabel('时间t(s)');ylabel('y(m)');
title('位置y-时间曲线');
grid on;
figure;
plot(t,tgt(:,3));
xlabel('时间t(s)');ylabel('z(m)');
title('位置z-时间曲线');
grid on;
figure;
plot(t,tgt(:,4));
xlabel('时间t(s)');ylabel('Vx(m)');
title('速度Vx-时间曲线');
grid on;
figure;
plot(t,tgt(:,5));
xlabel('时间t(s)');ylabel('Vy(m)');
title('速度Vy-时间曲线');
grid on;
figure;
plot(t,tgt(:,6));
xlabel('时间t(s)');ylabel('Vz(m)');
title('速度Vz-时间曲线');
grid on;
end

%% 天东北坐标系转换到基础坐标系
function c = CU2E(x, y, z)
% 在卫星处（ECF坐标系下知道xyz），获取UEN到ECF的转换矩阵
a = atan2(y,x);
b = atan(z/sqrt(x^2 +y^2));
a = -a; % 绕z反转
c = [cos(a) sin(a) 0; -sin(a) cos(a) 0; 0 0 1] * [cos(b) 0 -sin(b); 0 1 0; sin(b) 0 cos(b)];
end