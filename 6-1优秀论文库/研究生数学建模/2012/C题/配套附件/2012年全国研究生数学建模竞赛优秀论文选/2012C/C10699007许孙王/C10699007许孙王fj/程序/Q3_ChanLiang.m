%% 数据 1
nw = 0.98;              % 含水率
B0 = 1.025;             % 原油体积系数
p = 8.1;                % 井下压力
H = 793;                % 泵深
Ns = 7.6;               % 冲次
Spe = 2.018424;         % 有效冲程
Ap = pi*(70/2/1000).^2; % 泵截面积

%% t
t = 1/40 * (H-900) + 40;                 % 井下摄氏温度
%t

%% 计算Bw
matCA = [
    9.911e-1    6.35e-6     0.85e-6
    -1.093e-6   -0.3497e-8  0.457e-11
    -0.50e-10   0.6429e-12  -1.43e-15
    ];

theta = 1.8*t+32;
for i = 1:3
    C(i) = matCA(i,1) + matCA(i,2)*theta + matCA(i,3)*theta*theta;
end
Bw = C(1) + C(2)*(145.03*p) + C(3)*(145.03*p)^2;
%Bw

%% 计算eta_nu
eta_nu = 1 / ((1-nw)*B0 + nw*Bw);
fprintf('\n');
fprintf('eta_nu = %f\n', eta_nu);

%% Qp
Qp = 1440*Ns*Spe*Ap*eta_nu;
fprintf('日产油量(m^3) = %f\n', Qp);
