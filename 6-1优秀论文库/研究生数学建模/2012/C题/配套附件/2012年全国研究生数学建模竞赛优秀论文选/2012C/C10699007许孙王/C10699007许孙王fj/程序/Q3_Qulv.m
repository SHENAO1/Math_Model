
len = length(t);
t2 = linspace(t(1), t(end), len*1);
u_xm2 = spline(t,GuiYiHua(u_xm), t2);
F_xm2 = spline(t,GuiYiHua(F_xm), t2);

%% 数据
u_ql = ((u_xm2(1:end-1)));
F_ql = ((F_xm2(1:end-1)));
t_ql = t2(1:end-1); 
dt = t_ql(2)-t_ql(1);

%% u, F的一、二阶导数
du_ql = Daoshu_ring(u_ql, dt);
ddu_ql = Daoshu_ring(du_ql, dt);

dF_ql = Daoshu_ring(F_ql, dt);
ddF_ql = Daoshu_ring(dF_ql, dt);

%% 曲率公式
Qulv = abs(du_ql.*ddF_ql - ddu_ql.*dF_ql) ./ ((du_ql.^2+dF_ql.^2).^1.5);

%% 寻找极值点并在示功图中标出
isPeak = imregionalmax(Qulv);           % 标出哪些是极值点
% isPeak(:) = 1;

vec = 1:length(isPeak);
peaks = vec(isPeak);                    % 极值点的标号列表
peaks_value = Qulv(peaks);              % 极值点处的曲率
[peaks_value, indexs] = sort(peaks_value, 'descend');    % 对各极值点处的曲率排序
peaks = peaks(indexs);
peaks_u = u_xm2(peaks);          % 取出各极值点的位移
peaks_F = F_xm2(peaks);          % 取出各极值点的载荷

figure; hold on;
plot(u_xm2, F_xm2, '-' ,'linewidth',2);
plot(peaks_u, peaks_F, 'o', 'markersize',8, 'linewidth',2);
plot(peaks_u(1:5), peaks_F(1:5), 'ro', 'markersize',12, 'linewidth',2);
legend('\fontsize{12}泵示功图', '\fontsize{12}曲率极植点', '\fontsize{12}曲率极植点(最大的5个)', 'Location','Best');
xlabel('\fontsize{12}归一化位移'); ylabel('\fontsize{12}归一化载荷');
title('\fontsize{15}一级杆油井泵示功图');
% title('\fontsize{15}三级杆油井泵示功图');
xlim([-0.1, 1.1]);
ylim([-0.1, 1.1]);
grid on; box on;

figure; 
subplot(2,1,1);
hold on;
plot(t_ql, Qulv, 'linewidth',2);
plot(t_ql(peaks), Qulv(peaks), 'o', 'linewidth',2);
xlabel('\fontsize{12}时间 (s)'); ylabel('\fontsize{12}曲率 (m^{-1})');
legend('\fontsize{12}曲率', '\fontsize{12}曲率极值点');
title('\fontsize{15}一级杆油井一个冲程时间内的曲率-时间曲线');
% title('\fontsize{15}三级杆油井一个冲程时间内的曲率-时间曲线');
% ylim([0 50]);
box on; grid on;
hold off;


%% 寻找曲率变化极值点, 并在示功图中标出
dQulv_du = abs(Daoshu(Qulv, dt) ./ sqrt(du_ql.^2 + dF_ql.^2));

isPeak = imregionalmax(dQulv_du);           % 标出哪些是极值点

vec = 1:length(isPeak);
peaks = vec(isPeak);                    % 极值点的标号列表
peaks_value = Qulv(peaks);              % 极值点处的曲率
[peaks_value, indexs] = sort(peaks_value, 'descend');    % 对各极值点处的曲率排序
peaks = peaks(indexs);
peaks_u = u_xm2(peaks);          % 取出各极值点的位移
peaks_F = F_xm2(peaks);          % 取出各极值点的载荷

subplot(2,1,2); hold on;
plot(t_ql, dQulv_du, 'linewidth',2);
plot(t_ql(peaks), dQulv_du(peaks), 'o', 'linewidth',2);
xlabel('\fontsize{12}时间 (s)'); ylabel('\fontsize{12}曲率对弧长的变化率');
legend('\fontsize{12}曲率变化率(绝对值)', '\fontsize{12}曲率变化率绝对值的极值点');
title('\fontsize{15}一级杆油井一个冲程时间内的曲率变化率(绝对值)-时间曲线');
% title('\fontsize{15}三级杆油井一个冲程时间内的曲率变化率(绝对值)-时间曲线');
box on; grid on; hold off;

figure; hold on;
plot(u_xm2, F_xm2, '-' ,'linewidth',2);
plot(peaks_u, peaks_F, 'o', 'markersize',8, 'linewidth',2);
plot(peaks_u(1:8), peaks_F(1:8), 'ro', 'markersize',12, 'linewidth',2);
legend('\fontsize{12}泵示功图', '\fontsize{12}曲率变化极植点', '\fontsize{12}曲率变化极植点(最大的8个)', 'Location','Best');
xlabel('\fontsize{12}归一化位移'); ylabel('\fontsize{12}归一化载荷');
title('\fontsize{15}一级杆油井泵示功图');
% title('\fontsize{15}三级杆油井泵示功图');
xlim([-0.1, 1.1]);
ylim([-0.1, 1.1]);
grid on; box on;


