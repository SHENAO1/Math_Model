clear;

%% 参数
p_water = 0.912;                     % 含水率
chongci = 4;                        % 冲次
x = [523.61 664.32 618.35];         % 各节长
R = [25 22 19]/1000/2;              % 各节截面半径
gamma = 0.2304;                        % 阻尼系数(无量纲)

% 一个冲程中, 悬点载荷、悬点位移的值(等时间间隔采样)
L = [48.50,48.14,47.96,47.35,46.85,46.99,46.67,46.81,47.46,48.61,50.01,52.84,52.98,53.2,53.56,53.42,52.77,55.46,57.08,59.02,60.67,61.46,62.28,63.07,64.4,67.2,69.78,71.94,74.2,75.21,76.68,76.64,74.42,71.87,70.04,68.67,67.49,67.42,67.45,68.89,70.97,72.58,73.05,73.23,72.87,72.08,70.90,69.96,68.10,67.31,67.63,68.24,68.42,69.17,70.50,71.26,71.47,71.01,70.29,69.53,68.85,68.17,67.99,67.63,67.88,68.6,69.21,69.75,69.78,70.04,70.07,69.64,69.03,68.28,67.77,67.31,67.27,67.38,67.74,68.13,68.6,68.71,68.67,68.17,67.85,67.31,66.81,65.73,65.15,64.72,63.61,63.25,62.82,62.57,62.46,62.68,62.50,61.71,60.92,59.45,58.19,56.97,55.10,53.59,51.55,49.83,47.46,44.73,42.25,39.63,38.98,40.6,43.44,45.48,47.24,48.78,49.68,49.75,49.07,47.31,44.73,43.22,42.43,42.29,42.50,43.47,45.55,46.13,47.74,48.25,48.07,47.53,46.49,45.27,44.58,43.76,43.65,44.05,44.87,46.06,46.67,48.14,48.53
] .* 1000;
U = [0.24,0.19,0.15,0.11,0.08,0.05,0.03,0.01,0.00,0,0.00,0.01,0.02,0.04,0.07,0.10,0.14,0.18,0.23,0.28,0.34,0.40,0.47,0.53,0.61,0.68,0.76,0.84,0.92,1.01,1.09,1.18,1.27,1.36,1.46,1.55,1.65,1.74,1.84,1.93,2.03,2.12,2.22,2.31,2.41,2.50,2.60,2.69,2.78,2.87,2.96,3.05,3.14,3.22,3.31,3.39,3.47,3.55,3.63,3.71,3.78,3.85,3.92,3.99,4.06,4.12,4.18,4.24,4.30,4.35,4.40,4.45,4.49,4.54,4.58,4.61,4.65,4.68,4.71,4.73,4.76,4.77,4.79,4.79,4.80,4.80,4.80,4.79,4.77,4.75,4.73,4.70,4.67,4.63,4.58,4.53,4.48,4.42,4.35,4.29,4.21,4.14,4.05,3.97,3.89,3.80,3.71,3.61,3.52,3.42,3.32,3.22,3.12,3.01,2.91,2.80,2.70,2.59,2.48,2.37,2.26,2.16,2.05,1.94,1.84,1.73,1.63,1.53,1.43,1.33,1.23,1.14,1.05,0.96,0.87,0.79,0.71,0.63,0.55,0.48,0.42,0.35,0.30
];

L = [L L(1)];
U = [U U(1)];

E = 2.1e11;                 % 钢铁的弹性模量
rho_steel = 8456;           % 钢铁的密度
rho_oil = 864;              % 油的密度
rho_water = 1000;           % 水的密度
a = sqrt(E / rho_steel);    % 钢铁中声速
c = pi * a * gamma / (2.0 * sum(x));       	% 阻尼系数 
grav = 9.81;                % 重力加速度

%% 计算
rho_fluid = rho_water*p_water + rho_oil*(1-p_water);    % 油井中流体(油水混合物)的密度
A = pi .* (R.^2);         % 各节截面积
T = 60 / chongci;       % 周期, 一个冲程的时间
w = 2*pi*chongci / 60;  % 圆频率

Wr = sum(A.*x) * (rho_steel - rho_fluid) * grav;        % 抽油杆各节总重

m = length(x);          % 抽油杆的节数
K = length(L);          % 采样点数量
nF = 10;                % 算几阶Fourier级数
t = linspace(0, T, K);  % 时间\



%% Step 1
D = L - Wr;             % 动态载荷函数
sigma0(1)   = trapz(t, D.*cos(w*t*0))*w/pi;
tau0(1)     = trapz(t, D.*sin(w*t*0))*w/pi;
nu0(1)      = trapz(t, U.*cos(w*t*0))*w/pi;
delta0(1)   = trapz(t, U.*sin(w*t*0))*w/pi;
for n = 1:nF
    sigma(1, n) = trapz(t, D.*cos(w*t*n))*w/pi;
    tau(1, n)   = trapz(t, D.*sin(w*t*n))*w/pi;
    nu(1, n)    = trapz(t, U.*cos(w*t*n))*w/pi;
    delta(1, n) = trapz(t, U.*sin(w*t*n))*w/pi;
end

%% Step 2
for n = 1:nF
    alpha(n)    = n*w/(a*sqrt(2)) * sqrt( 1+sqrt(1+(c/(n*w)).^2) );
    beta(n)     = n*w/(a*sqrt(2)) * sqrt( -1+sqrt(1+(c/(n*w)).^2) );
    kappa(1, n) = (sigma(1,n)*alpha(n) + tau(1,n)*beta(n)) /    ...
                    ( E*A(1)*((alpha(n))^2+(beta(n))^2) );
    mu(1,n)       = (sigma(1,n)*beta(n) - tau(1,n)*alpha(n)) /    ...
                    ( E*A(1)*((alpha(n))^2+(beta(n))^2) );
                
    O(1, n) = (kappa(1,n)*cosh(beta(n)*x(1))+delta(1,n)*sinh(beta(n)*x(1)))*sin(alpha(n)*x(1)) ...
             +(mu(1,n)*sinh(beta(n)*x(1))+nu(1,n)*cosh(beta(n)*x(1)))*cos(alpha(n)*x(1));
    P(1, n) = (kappa(1,n)*sinh(beta(n)*x(1))+delta(1,n)*cosh(beta(n)*x(1)))*cos(alpha(n)*x(1)) ...
             -(mu(1,n)*cosh(beta(n)*x(1))+nu(1,n)*sinh(beta(n)*x(1)))*sin(alpha(n)*x(1));
    DO(1,n) = ( tau(1,n)/(E*A(1))*sinh(beta(n)*x(1)) + (delta(1,n)*beta(n)-nu(1,n)*alpha(n))*cosh(beta(n)*x(1)) )*sin(alpha(n)*x(1)) ...
             +( sigma(1,n)/(E*A(1))*cosh(beta(n)*x(1)) + (nu(1,n)*beta(n)+delta(1,n)*alpha(n))*sinh(beta(n)*x(1)) )*cos(alpha(n)*x(1));
    DP(1,n) = ( tau(1,n)/(E*A(1))*cosh(beta(n)*x(1)) + (delta(1,n)*beta(n)-nu(1,n)*alpha(n))*sinh(beta(n)*x(1)) )*cos(alpha(n)*x(1)) ...
             -( sigma(1,n)/(E*A(1))*sinh(beta(n)*x(1)) + (nu(1,n)*beta(n)+delta(1,n)*alpha(n))*cosh(beta(n)*x(1)) )*sin(alpha(n)*x(1));
end

%% Step 3
for j = 1:(m-1)
    nu0(j+1)    = sigma0(j)*x(j) / (E*A(j)) + nu0(j);
    sigma0(j+1) = sigma0(j);
    for n = 1:nF
        nu(j+1, n)      = O(j, n);
        delta(j+1, n)   = P(j, n);
        sigma(j+1, n)   = E * A(j) * DO(j, n);
        tau(j+1, n)     = E * A(j) * DP(j, n);
        
        kappa(j+1, n)   = ( sigma(j+1,n)*alpha(n) + tau(j+1,n)*beta(n) )    ...
                         /( E * A(j+1) * ((alpha(n))^2+(beta(n))^2) );
        mu(j+1, n)      = ( sigma(j+1,n)*beta(n) - tau(j+1,n)*alpha(n) )    ...
                         /( E * A(j+1) * ((alpha(n))^2+(beta(n))^2) );
                     
        O(j+1, n) = (kappa(j+1,n)*cosh(beta(n)*x(j+1))+delta(j+1,n)*sinh(beta(n)*x(j+1)))*sin(alpha(n)*x(j+1)) ...
                   +(mu(j+1,n)*sinh(beta(n)*x(j+1))+nu(j+1,n)*cosh(beta(n)*x(j+1)))*cos(alpha(n)*x(j+1));
        P(j+1, n) = (kappa(j+1,n)*sinh(beta(n)*x(j+1))+delta(j+1,n)*cosh(beta(n)*x(j+1)))*cos(alpha(n)*x(j+1)) ...
                   -(mu(j+1,n)*cosh(beta(n)*x(j+1))+nu(j+1,n)*sinh(beta(n)*x(j+1)))*sin(alpha(n)*x(j+1));
        DO(j+1,n) = ( tau(j+1,n)/(E*A(j+1))*sinh(beta(n)*x(j+1)) + (delta(j+1,n)*beta(n)-nu(j+1,n)*alpha(n))*cosh(beta(n)*x(j+1)) )*sin(alpha(n)*x(j+1)) ...
                   +( sigma(j+1,n)/(E*A(j+1))*cosh(beta(n)*x(j+1)) + (nu(j+1,n)*beta(n)+delta(j+1,n)*alpha(n))*sinh(beta(n)*x(j+1)) )*cos(alpha(n)*x(j+1));
        DP(j+1,n) = ( tau(j+1,n)/(E*A(j+1))*cosh(beta(n)*x(j+1)) + (delta(j+1,n)*beta(n)-nu(j+1,n)*alpha(n))*sinh(beta(n)*x(j+1)) )*cos(alpha(n)*x(j+1)) ...
                   -( sigma(j+1,n)/(E*A(j+1))*sinh(beta(n)*x(j+1)) + (nu(j+1,n)*beta(n)+delta(j+1,n)*alpha(n))*cosh(beta(n)*x(j+1)) )*sin(alpha(n)*x(j+1));
    end
end

for i = 1:length(t)
    cos_vec = cos([1:nF]*w*t(i));
    sin_vec = sin([1:nF]*w*t(i));
    
    u_xm(i) = sigma0(m) / (2*E*A(m)) * x(m) + nu0(m)/2 + sum(O(m, :).*cos_vec) + sum(P(m,:).*sin_vec);
    F_xm(i) = E*A(m)*( sigma0(m)/(2*E*A(m)) +  sum(DO(m, :).*cos_vec) + sum(DP(m,:).*sin_vec) );
end

figure; hold on;
plot(U, L/1000, 'r--' ,'linewidth',2);
plot(u_xm, F_xm/1000, '-' ,'linewidth',2);
xlim([-0.5 5.5]);
legend('悬点示功图', '泵示功图','Location','Best');
xlabel('\fontsize{12}位移 (m)'); ylabel('\fontsize{12}载荷 (kN)');
title('\fontsize{15}三级杆油井示功图 (由阻尼因子\gamma计算阻尼系数c)');
grid on; box on;

%%
figure; 
subplot(2,1,1); hold on;
plot(t, U, 'r--','linewidth',2);
plot(t, u_xm, '-' ,'linewidth',2);
legend('悬点处', '泵处','Location','Best');
xlabel('\fontsize{12}时间 (s)'); ylabel('\fontsize{12}位移 (m)');
title('\fontsize{15}三级杆油井位移-时间曲线 (由阻尼因子\gamma计算阻尼系数c)'); 
grid on; box on;
hold off;

subplot(2,1,2); hold on;
plot(t, L/1000, 'r--','linewidth',2);
plot(t, F_xm/1000, '-' ,'linewidth',2);
legend('悬点处', '泵处','Location','Best');
xlabel('\fontsize{12}时间 (s)'); ylabel('\fontsize{12}载荷 (kN)');
title('\fontsize{15}三级杆油井载荷-时间曲线 (由阻尼因子\gamma计算阻尼系数c)');
grid on; box on;
hold off;




