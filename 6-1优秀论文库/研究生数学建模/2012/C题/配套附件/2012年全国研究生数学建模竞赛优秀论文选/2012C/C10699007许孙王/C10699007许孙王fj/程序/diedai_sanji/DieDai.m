% 迭代求c !!
clear;

%% 起始点1
C_History1 = [];
c = 1;                          % 使用其它方法(这里用的是摩擦功)给一个初始的c
C_History1 = [C_History1, c];
for i = 1:5
    dd_Q2Calc_FDM;              % 使用有限差分法计算u(x,t)
    dd_Q3_Qulv; dd_findABCD;    % 计算曲率, 并自动找出A,B,C,D点
    dd_Q3_ChanLiang_useWork;    % 从W=(总功-势能)的角度求出一个冲程的摩擦功mocagong
    dd_Q4_CalcC_useWork;        % 从摩擦力做功的角度积分求出一个冲程的摩擦功W
    c = mocagong / W;           % 计算新的c, 等于mocagong和W的比值
    C_History1 = [C_History1, c];
end;
%% 起始点2
C_History2 = [];
c = 2;                          % 使用其它方法(这里用的是摩擦功)给一个初始的c
C_History2 = [C_History2, c];
for i = 1:5
    dd_Q2Calc_FDM;              % 使用有限差分法计算u(x,t)
    dd_Q3_Qulv; dd_findABCD;    % 计算曲率, 并自动找出A,B,C,D点
    dd_Q3_ChanLiang_useWork;    % 从W=(总功-势能)的角度求出一个冲程的摩擦功mocagong
    dd_Q4_CalcC_useWork;        % 从摩擦力做功的角度积分求出一个冲程的摩擦功W
    c = mocagong / W;           % 计算新的c, 等于mocagong和W的比值
    C_History2 = [C_History2, c];
end;
%% 起始点3
C_History3 = [];
c = 3;                          % 使用其它方法(这里用的是摩擦功)给一个初始的c
C_History3 = [C_History3, c];
for i = 1:5
    dd_Q2Calc_FDM;              % 使用有限差分法计算u(x,t)
    dd_Q3_Qulv; dd_findABCD;    % 计算曲率, 并自动找出A,B,C,D点
    dd_Q3_ChanLiang_useWork;    % 从W=(总功-势能)的角度求出一个冲程的摩擦功mocagong
    dd_Q4_CalcC_useWork;        % 从摩擦力做功的角度积分求出一个冲程的摩擦功W
    c = mocagong / W;           % 计算新的c, 等于mocagong和W的比值
    C_History3 = [C_History3, c];
end;

%% 绘图
figure; hold on;
plot(0:length(C_History1)-1, C_History1, '-bo', 'linewidth', 2, 'markersize', 10);
plot(0:length(C_History2)-1, C_History2, '--s', 'linewidth', 2, 'color', [0 0.5 0], 'markersize', 10);
plot(0:length(C_History3)-1, C_History3, '-.r^', 'linewidth', 2, 'markersize', 10);
grid on; xlim([0 inf]); ylim([0.5 3.5]);
xlabel('\fontsize{12}迭代次数'); ylabel('\fontsize{12}阻尼系数c')
legend('\fontsize{12}起始点c=1', '\fontsize{12}起始点c=2', '\fontsize{12}起始点c=3');
title('\fontsize{15}不同起始点下,阻尼系数c的迭代收敛曲线(三级杆油井)');
