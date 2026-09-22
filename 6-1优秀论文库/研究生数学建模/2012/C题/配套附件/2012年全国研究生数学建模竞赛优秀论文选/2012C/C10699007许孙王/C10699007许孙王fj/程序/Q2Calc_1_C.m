%clear;

%% 参数
p_water = 0.98;                     % 含水率
chongci = 7.6;                      % 冲次
x = [792.5];                        % 各节长
R = [22]/1000/2;                    % 各节截面半径
gamma = 0.2304;                        % 阻尼系数(无量纲)

% 一个冲程中, 悬点载荷、悬点位移的值(等时间间隔采样)
L = [39.7,39.665,39.665,38.131,31.822,30.184,28.372,27.047,26.385,23.806,19.17,16.765,14.988,13.245,11.885,14.221,17.114,19.693,20.808,22.446,23.422,21.087,18.996,16.451,15.545,13.698,13.001,14.465,16.277,18.159,17.183,17.323,17.288,16.521,15.371,14.709,15.057,14.43,14.256,14.36,14.534,14.709,14.883,14.778,14.813,14.709,14.953,15.266,15.406,15.301,15.51,16.242,16.73,17.253,17.671,18.612,19.031,19.344,20.146,20.808,21.784,21.959,22.69,23.213,23.492,23.353,23.388,23.806,24.12,24.538,24.886,25.339,28.546,31.16,33.251,35.412,37.957,40.78,46.148,50.4,53.99,55.942,56.883,57.092,57.545,58.103,58.138,58.242,58.347,58.068,58.068,58.242,58.661,58.905,59.462,60.02,60.891,61.205,61.344,60.891,61.275,61.066,60.752,59.811,59.497,58.87,58.033,57.615,57.232,56.465,55.524,55.036,54.408,53.955,53.502,53.537,53.049,53.223,52.7,52.247,52.178,52.247,51.481,50.783,50.33,49.807,49.041,48.274,47.298,46.74,45.834,45.59,45.207,44.963,44.684,44.405,44.196,43.917,43.603,43.115,42.732,41.965,40.85,40.257
] .* 1000;
U = [2.518,2.512,2.504,2.495,2.484,2.472,2.459,2.444,2.427,2.41,2.391,2.372,2.351,2.329,2.305,2.281,2.256,2.229,2.201,2.172,2.142,2.111,2.079,2.046,2.011,1.975,1.938,1.9,1.86,1.82,1.778,1.735,1.69,1.645,1.598,1.55,1.501,1.451,1.399,1.347,1.294,1.239,1.184,1.129,1.072,1.015,0.958,0.901,0.844,0.786,0.729,0.673,0.618,0.563,0.51,0.459,0.409,0.361,0.315,0.272,0.231,0.193,0.158,0.127,0.098,0.074,0.052,0.034,0.02,0.01,0.003,0,0,0.004,0.012,0.023,0.037,0.054,0.074,0.097,0.123,0.152,0.183,0.216,0.251,0.289,0.328,0.369,0.412,0.456,0.501,0.548,0.596,0.645,0.694,0.745,0.797,0.849,0.901,0.954,1.008,1.062,1.116,1.17,1.225,1.279,1.334,1.388,1.442,1.496,1.55,1.603,1.655,1.707,1.758,1.808,1.858,1.906,1.953,1.999,2.043,2.086,2.127,2.167,2.205,2.241,2.275,2.307,2.337,2.365,2.391,2.414,2.435,2.454,2.471,2.485,2.497,2.507,2.515,2.52,2.524,2.525,2.524,2.522
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

A = pi .* (R.^2);           % 各节截面积
w = 2*pi*chongci / 60;  % 圆频率
%% 计算c
% 用摩擦功确定阻尼系数，只能处理一段抽油杆情形
Dt = 70/1000;       % 油管内径
Dr = 22/1000;       % 抽油杆直径
Ar = A(1);          % 抽油杆截面积
vis_oil = 30/1000;  % 地面原油粘度
m = Dt/Dr;
B1 = (m^2-1) / (2*log(m)) - 1;
B2 = m^4 - 1 - (m^2-1)^2 / log(m);
c = 2*pi*vis_oil / (rho_steel*Ar) *  ...
    ( 1/log(m) + 2/B2*(B1+1) * ...
    (B1 + 2/( (w*x(1)/a)/sin(w*x(1)/a) + cos(w*x(1)/a) )));

%% 计算
rho_fluid = rho_water*p_water + rho_oil*(1-p_water);    % 油井中流体(油水混合物)的密度
T = 60 / chongci;       % 周期, 一个冲程的时间

Wr = sum(A.*x) * (rho_steel - rho_fluid) * grav;        % 抽油杆各节总重

m = length(x);          % 抽油杆的节数
K = length(L);          % 采样点数量
nF = 10;                % 算几阶Fourier级数
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
legend('悬点示功图', '泵示功图','Location','Best');
xlabel('\fontsize{12}位移 (m)'); ylabel('\fontsize{12}载荷 (kN)');
title('\fontsize{15}一级杆油井示功图 (由摩擦功计算阻尼系数c)');
xlim([-0.2, 2.9]);
ylim([-20, 70]);
grid on; box on;

%%
figure; 
subplot(2,1,1); hold on;
plot(t, U, 'r--','linewidth',2);
plot(t, u_xm, '-' ,'linewidth',2);
legend('悬点处', '泵处','Location','Best');
xlabel('\fontsize{12}时间 (s)'); ylabel('\fontsize{12}位移 (m)');
title('\fontsize{15}一级杆油井位移-时间曲线 (由摩擦功计算阻尼系数c)'); 
grid on; box on;
hold off;

subplot(2,1,2); hold on;
plot(t, L/1000, 'r--','linewidth',2);
plot(t, F_xm/1000, '-' ,'linewidth',2);
legend('悬点处', '泵处','Location','Best');
xlabel('\fontsize{12}时间 (s)'); ylabel('\fontsize{12}载荷 (kN)');
title('\fontsize{15}一级杆油井载荷-时间曲线 (由摩擦功计算阻尼系数c)');
grid on; box on;
hold off;




