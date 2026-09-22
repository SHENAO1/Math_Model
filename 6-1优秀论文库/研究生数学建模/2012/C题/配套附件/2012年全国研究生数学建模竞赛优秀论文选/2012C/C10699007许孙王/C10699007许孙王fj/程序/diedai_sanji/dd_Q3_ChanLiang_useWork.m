%% 数据2
% index_A = 68;   % A,B,C,D四点的标号
% index_B = 87;
% index_C = 139;
% index_D = 16;

%% 数据 2
nw = 0.912;             % 含水率
B0 = 1.025;             % 原油体积系数
p = 20;                 % 井下压力
H = 1819.56;            % 泵深
Ns = 4;                 % 冲次
Spe = 3.106316;         % 有效冲程
Ap = pi*(44/2/1000).^2; % 泵截面积

u_cl = u_xm;
F_cl = F_xm;
len = length(u_cl);
grav = 9.81;

%% 求出4个段
S{1} = index_A : index_B;
if isempty(S{1})
    S{1} = [index_A:len, 1:index_B];
end
S{2} = index_B : index_C;
if isempty(S{2})
    S{2} = [index_B:len, 1:index_C];
end
S{3} = index_C : index_D;
if isempty(S{3})
    S{3} = [index_C:len, 1:index_D];
end
S{4} = index_D : index_A;
if isempty(S{4})
    S{4} = [index_D:len, 1:index_A];
end

%% 试画
% figure; hold on;
% plot(u_cl(S{1}),F_cl(S{1}), u_cl(S{2}),F_cl(S{2}), u_cl(S{3}),F_cl(S{3}), u_cl(S{4}),F_cl(S{4}), 'linewidth', 3);
% box on; grid on; hold off;

%% 计算4段的功
for i = 1:4
    Work(i) = trapz(u_cl(S{i}), F_cl(S{i}));
end

for i = 1:4
    deltaU(i) = u_cl(S{i}(end)) - u_cl(S{i}(1));
    Ep_fluid(i) = H*Ap*grav * rho_fluid * deltaU(i);
end

Qp2 = sum(Ep_fluid([1:3])) * Ns * 60 * 24 / (rho_fluid*grav*H);
% fprintf('日产油量算法2 (m^3) = %f\n', Qp2);

mocagong = sum(Work) - sum(Ep_fluid(1:3));