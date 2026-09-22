clc;
clear;

%实验结果
phi_exp = [0: 2*pi/(147-4) :2*pi]'; 
E_dis_exp = load ('E_dis_exp_new.dat');  % m
x=phi_exp;
f=inline('c(1)*sin(c(2)*x+c(3))+c(4)','c','x');
c=lsqcurvefit(f,[1,1,1,1],phi_exp,E_dis_exp);
f_exp= c(1)*sin(c(2)*x+c(3))+c(4);

t = 60/7.6/629; %s 
t_exp =60/7.6/144;
phi_expv = [0 : 2*pi/(147-4):2*pi-(2*pi/(147-4))]';
phi_expa = [0 : 2*pi/(147-4):2*pi-2*(2*pi/(147-4))]';
E_Vt_exp = diff(f_exp)/t_exp;
E_Vt_expr = diff(E_dis_exp)/t_exp;
fit_Vt=polyfit(phi_expv,E_Vt_expr,9);
fit_Vt_exp = polyval(fit_Vt,phi_expv);
E_at_exp = diff(fit_Vt_exp)/t_exp;

%曲柄连杆方法
ao = 4315; % mm
bo = 2495; % mm
bd = 3675; % mm
r = 950; % mm
phi = 0 : 0.01 : 2*pi;
phi_v = [0:0.01:2*pi-0.01]';
phi_a = 0:0.01:2*pi-0.02;
lamda = r / bo;
S_qb = ao/bo*(2*r); 
E_dis_qb = ao / bo * r * (1- cos(phi)+ lamda/2 * (sin (phi)).^2)/1000; % m
E_Vt_qb = diff(E_dis_qb)/t; %m/s
E_at_qb = diff(E_Vt_qb)/t;  %m/s*s

%简谐振动方法
E_dis_jx = ao / bo * r *(1- cos(phi))/1000;   %m
E_Vt_jx = diff(E_dis_jx)/t; %m/s
E_at_jx = diff(E_Vt_jx)/t;  %m/s*s
S_jx = ao/bo*(2*r); 

%严格解析法
E_dis_yg = load ('E_dis_ygjx.dat'); %m
E_Vt_yg = diff(E_dis_yg)/t; %m/s
fit_Vt_yg=polyfit(phi_v,E_Vt_yg,9);
fit_Vt_ygr = polyval(fit_Vt_yg,phi_v);
E_at_yg = load('a_jqjx.dat');  %m/s*s

figure (1)
hold on;
set(gca,'box','on')
set(gca,'linewidth',2);
plot(phi, E_dis_qb,'-','LineWidth',2);  
plot(phi, E_dis_jx,'black--','LineWidth',2);
plot(phi, E_dis_yg,'m-.','LineWidth',2);
plot(phi_exp, E_dis_exp,'r.','LineWidth',2);
plot(phi_exp, f_exp,'g-','LineWidth',2);
xlabel('\phi / rad ','fontsize',16);
ylabel('E-displacement / m','fontsize',16);
legend('曲柄连杆近似','简谐近似','严格解析法','实验悬点位移','实验悬点位移拟合值');

figure (2)
hold on;
set(gca,'box','on')
set(gca,'linewidth',2);
plot(phi_v, E_Vt_qb,'-','LineWidth',2);
plot(phi_v, E_Vt_jx,'black--','LineWidth',2);
plot(phi_v, E_Vt_yg,'m-.','LineWidth',2);
plot(phi_expv, E_Vt_expr,'r.','LineWidth',2);
plot(phi_expv, fit_Vt_exp,'g-','LineWidth',2);
xlabel('\phi / rad ','fontsize',16);
ylabel('E-V / ms^{-1}','fontsize',16);
legend('曲柄近似','简谐近似','严格解析法','实验悬点速度','实验悬点速度拟合');

figure(3)
hold on;
set(gca,'box','on')
set(gca,'linewidth',2);
plot(phi_a, E_at_qb,'-','LineWidth',2);
plot(phi_a, E_at_jx,'black--','LineWidth',2);
plot(phi, E_at_yg,'m-.','LineWidth',2);
plot(phi_expa, E_at_exp,'r-','LineWidth',2);
xlabel('\phi / rad ','fontsize',16,'LineWidth',2);
ylabel('E-a / ms^{-2}','fontsize',16);
legend('曲柄近似','简谐近似','严格解析法','实验悬点加速度');

figure (4)
hold on;
set(gca,'box','on')
set(gca,'linewidth',2);
plot(phi, E_dis_jx,'r-','LineWidth',2);
plot(phi_v, E_Vt_jx,'black--','LineWidth',2);
plot(phi_a, E_at_jx,'m-.','LineWidth',2);
xlabel('\phi / rad ','fontsize',16);
ylabel('变量','fontsize',16);
legend('位移 / m','速度 / ms^{-1}','加速度 / ms^{-2}');

figure (5)
hold on;
set(gca,'box','on')
set(gca,'linewidth',2);
plot(phi, E_dis_qb,'r-','LineWidth',2);
plot(phi_v, E_Vt_qb,'black--','LineWidth',2);
plot(phi_a, E_at_qb,'-.','LineWidth',2);
xlabel('\phi / rad ','fontsize',16);
ylabel('变量','fontsize',16);
legend('位移 / m','速度 / ms^{-1}','加速度 / ms^{-2}');