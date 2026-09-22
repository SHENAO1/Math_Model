
%% 参数
p_water = 0.95;                     % 含水率
chongci = 12;                       % 冲次
x = [172.56	334.57	330.13];                        % 各节长
R = [25	22	19]/1000/2;                    % 各节截面半径
gamma = 0.1;                        % 阻尼系数(无量纲)

% 一个冲程中, 悬点载荷、悬点位移的值(等时间间隔采样)
L = [28.75	29.08	29.53	30.22	31.18	32.14	33.24	34.07	35.35	36.81	38.28	39.93	41.76	43.18	44.96	45.47	44.78	43.73	42.72	42.31	42.54	43.32	44.14	44.55	44.32	43.64	43.18	42.95	42.95	43.27	43.36	43.09	42.63	42.12	41.94	42.45	43.13	43.5	43.64	43.22	42.31	41.62	41.48	41.67	42.54	43.45	43.86	43.82	43.27	42.67
] .* 1000;
U = [0	0.01	0.02	0.03	0.04	0.05	0.07	0.09	0.11	0.13	0.15	0.18	0.21	0.24	0.27	0.3	0.34	0.38	0.42	0.46	0.5	0.54	0.59	0.63	0.68	0.73	0.78	0.83	0.88	0.93	0.98	1.04	1.09	1.15	1.2	1.26	1.32	1.37	1.43	1.49	1.55	1.6	1.66	1.72	1.77	1.83	1.89	1.94	1.99	2.05
];

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
nF = 50;                % 算几阶Fourier级数
t = linspace(0, T, K);  % 时间

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
             +( delta(1,n)/(E*A(1))*cosh(beta(n)*x(1)) + (nu(1,n)*beta(n)+delta(1,n)*alpha(n))*sinh(beta(n)*x(1)) )*cos(alpha(n)*x(1));
    DP(1,n) = ( tau(1,n)/(E*A(1))*cosh(beta(n)*x(1)) + (delta(1,n)*beta(n)-nu(1,n)*alpha(n))*sinh(beta(n)*x(1)) )*cos(alpha(n)*x(1)) ...
             -( delta(1,n)/(E*A(1))*sinh(beta(n)*x(1)) + (nu(1,n)*beta(n)+delta(1,n)*alpha(n))*cosh(beta(n)*x(1)) )*sin(alpha(n)*x(1));
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
        mu(j+1, n)      = ( sigma(j+1,n)*beta(n) + tau(j+1,n)*alpha(n) )    ...
                         /( E * A(j+1) * ((alpha(n))^2+(beta(n))^2) );
                     
        O(j+1, n) = (kappa(j+1,n)*cosh(beta(n)*x(j+1))+delta(j+1,n)*sinh(beta(n)*x(j+1)))*sin(alpha(n)*x(j+1)) ...
                   +(mu(j+1,n)*sinh(beta(n)*x(j+1))+nu(j+1,n)*cosh(beta(n)*x(j+1)))*cos(alpha(n)*x(j+1));
        P(j+1, n) = (kappa(j+1,n)*sinh(beta(n)*x(j+1))+delta(j+1,n)*cosh(beta(n)*x(j+1)))*cos(alpha(n)*x(j+1)) ...
                   -(mu(j+1,n)*cosh(beta(n)*x(j+1))+nu(j+1,n)*sinh(beta(n)*x(j+1)))*sin(alpha(n)*x(j+1));
        DO(j+1,n) = ( tau(j+1,n)/(E*A(j+1))*sinh(beta(n)*x(j+1)) + (delta(j+1,n)*beta(n)-nu(j+1,n)*alpha(n))*cosh(beta(n)*x(j+1)) )*sin(alpha(n)*x(j+1)) ...
                   +( delta(j+1,n)/(E*A(j+1))*cosh(beta(n)*x(j+1)) + (nu(j+1,n)*beta(n)+delta(j+1,n)*alpha(n))*sinh(beta(n)*x(j+1)) )*cos(alpha(n)*x(j+1));
        DP(j+1,n) = ( tau(j+1,n)/(E*A(j+1))*cosh(beta(n)*x(j+1)) + (delta(j+1,n)*beta(n)-nu(j+1,n)*alpha(n))*sinh(beta(n)*x(j+1)) )*cos(alpha(n)*x(j+1)) ...
                   -( delta(j+1,n)/(E*A(j+1))*sinh(beta(n)*x(j+1)) + (nu(j+1,n)*beta(n)+delta(j+1,n)*alpha(n))*cosh(beta(n)*x(j+1)) )*sin(alpha(n)*x(j+1));
    end
end

for i = 1:length(t)
    cos_vec = cos([1:nF]*w*t(i));
    sin_vec = sin([1:nF]*w*t(i));
    
    u_xm(i) = sigma0(m) / (2*E*A(m)) * x(m) + nu0(m)/2 + sum(O(m, :).*cos_vec) + sum(P(m,:).*sin_vec);
    F_xm(i) = E*A(m)*( sigma0(m)/(2*E*A(m)) +  sum(DO(m, :).*cos_vec) + sum(DP(m,:).*sin_vec) );
end

figure; hold on;
plot(U, L, '-' ,'linewidth',2);
%plot(u_xm, F_xm, '--' ,'linewidth',2);
legend('悬点示功图', '泵示功图');
xlabel('位移 (m)'); ylabel('载荷 (N)');
title('一级杆油井示功图');



