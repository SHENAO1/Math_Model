oldFunctions;

%% 油井1
AO = 4315; BO = 2495; BD = 3675; R = 950; W = 7.6*2*pi / 60;
phi = linspace(0, 2*pi, 144);
t = phi / W; dt = t(2)-t(1);
% 位移
figure;
plot(   phi, Displacement_A(AO, BO, BD, R, W, phi)/1000, 'b-.',     ...
        phi, Displacement_B(AO, BO, BD, R, W, phi)/1000, 'b--',    ...
        phi, Displacement_C(AO, BO, BD, R, W, pi/2 - phi)/1000, 'b-', 'linewidth', 2);
legend('\fontsize{12}简谐近似', '\fontsize{12}曲柄滑块近似', '\fontsize{12}精确模型');
xlabel('\fontsize{12}时间(s)'); ylabel('\fontsize{12}位移(m)');
title('\fontsize{15}三种模型的位移-时间曲线');
grid on;
% 速度
figure;
plot(   phi, Daoshu_ring( Displacement_A(AO, BO, BD, R, W, phi), dt)/1000, 'b-.', 	...
        phi, Daoshu_ring( Displacement_B(AO, BO, BD, R, W, phi), dt)/1000, 'b--',	...
        phi, Daoshu_ring( Displacement_C(AO, BO, BD, R, W, pi/2 - phi), dt)/1000, 'b-', 'linewidth', 2);
legend('\fontsize{12}简谐近似', '\fontsize{12}曲柄滑块近似', '\fontsize{12}精确模型');
xlabel('\fontsize{12}时间(s)'); ylabel('\fontsize{12}速度(m/s)');
title('\fontsize{15}三种模型的速度-时间曲线');
grid on;
% 加速度
figure;
plot(   phi, Daoshu_ring( Daoshu_ring( Displacement_A(AO, BO, BD, R, W, phi), dt), dt)/1000, 'b-.', 	...
        phi, Daoshu_ring( Daoshu_ring( Displacement_B(AO, BO, BD, R, W, phi), dt), dt)/1000, 'b--', 	...
        'linewidth', 2);
legend('\fontsize{12}简谐近似', '\fontsize{12}曲柄滑块近似', '\fontsize{12}精确模型');
xlabel('\fontsize{12}时间(s)'); ylabel('\fontsize{12}加速度(m/s^2)');
title('\fontsize{15}两种模型的加速度-时间曲线');
grid on;



%% 参数微调对比
figure; hold on; title('AO');
for AOO = AO-500 : 100 : AO+500
    if AOO == AO-500
        plot (phi, Displacement_C(AOO, BO, BD, R, W, pi/2 - phi), 'r', 'linewidth', 2);
    else
        plot (phi, Displacement_C(AOO, BO, BD, R, W, pi/2 - phi));
    end
end
hold off;

figure; hold on; title('BO');
for BOO = BO-500 : 100 : BO+500
    if BOO == BO-500
        plot (phi, Displacement_C(AO, BOO, BD, R, W, pi/2 - phi), 'r', 'linewidth', 2);
    else
        plot (phi, Displacement_C(AO, BOO, BD, R, W, pi/2 - phi));
    end
end
hold off;

figure; hold on; title('BD');
for BDD = BD-500 : 100 : BD+500
    if BDD == BD-500
        plot (phi, Displacement_C(AO, BO, BDD, R, W, pi/2 - phi), 'r', 'linewidth', 2);
    else
        plot (phi, Displacement_C(AO, BO, BDD, R, W, pi/2 - phi));
    end
end
hold off;

figure; hold on; title('R');
for RR = R-100 : 20 : R+100
    if RR == R-100
        plot (phi, Displacement_C(AO, BO, BD, RR, W, pi/2 - phi), 'r', 'linewidth', 2);
    else
        plot (phi, Displacement_C(AO, BO, BD, RR, W, pi/2 - phi));
    end
end
hold off;

%%
figure; hold on; title('ALL');
for rate = 0: 1 : 10
    AOO = AO*(1-rate/100);
    BOO = BO*(1+rate/100);
    BDD = BD*(1+rate/100);
    RR = R*(1-rate/100);
    if rate == 0
        plot (phi, Displacement_C(AOO, BOO, BDD, RR, W, pi/2 - phi), 'r', 'linewidth', 2);
    else
        plot (phi, Displacement_C(AOO, BOO, BDD, RR, W, pi/2 - phi));
    end
end
plot(   phi, Displacement_A(AO, BO, BD, R, W, phi), '.',   ...
        phi, Displacement_B(AO, BO, BD, R, W, phi), '.',   ...
        phi, dis2*1000, '.');
hold off;

%%daoshu
figure; hold on; title('ALL_daoshu'); dphi = phi(2) - phi(1);
for rate = 0: 1 : 10
    AOO = AO*(1-rate/100);
    BOO = BO*(1+rate/100);
    BDD = BD*(1+rate/100);
    RR = R*(1-rate/100);
    
    Dis = Displacement_C(AOO, BOO, BDD, RR, W, pi/2 - phi);
    dDis = Daoshu(Dis, dphi);
    if rate == 0
        plot (phi, dDis, 'r', 'linewidth', 2);
    else
        plot (phi, dDis);
    end
end
plot(   phi, Daoshu(Displacement_A(AO, BO, BD, R, W, phi), dphi), '.',   ...
        phi, Daoshu(Displacement_B(AO, BO, BD, R, W, phi), dphi), '.',   ...
        phi, Daoshu(dis2'*1000, dphi), '.');
hold off;
