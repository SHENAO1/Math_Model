%% 数据

L_rod = [792.5];                % 各节长
Ar = Ar(1);                     % 截面积
uu = u(:, 2:end-1);
c = 2.6527;
rho = rho_steel - rho_fluid;

%% 计算
duu_dt = zeros(size(uu));
[lenDiv timeDiv] = size(uu);
dx = dx;
dt = dt;
for i = 1:lenDiv
    duu_dt(i,:) = Daoshu_ring(uu(i,:), dt);
end

W = 0;
for j = 1:timeDiv
    F = 0;
    for i = 1:lenDiv
        dF = c*rho*Ar*dx * duu_dt(i,j);
        F = F+abs(dF);
    end
    dW = F*dt;
    W = W+dW;
end



