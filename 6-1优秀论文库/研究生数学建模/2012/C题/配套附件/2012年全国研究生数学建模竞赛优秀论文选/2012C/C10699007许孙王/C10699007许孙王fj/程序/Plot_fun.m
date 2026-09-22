
clc;

% 比较相位关系
figure; hold on;
plot(t(1:end-1),u_xm(1:end-1),'b-','linewidth',2)
plot(t(1:end-1),u(end,2:end-1),'b--','linewidth',2)
plot(t,U,'r-.','linewidth',2)
legend('\fontsize{12}Gibbs求解方法','\fontsize{12}有限差分法','\fontsize{12}悬点示功图');
title('\fontsize{15}一级杆油井泵位移-时间曲线');
xlabel('\fontsize{12}时间 (s)'); ylabel('\fontsize{12}位移 (m)');
grid on; box on;
hold off;

% % 比较示功图
% figure; hold on;
% plot(U, L/1000, 'r-' ,'linewidth',2);
% plot(u_xm, F_xm/1000, '--' ,'linewidth',2);
% plot(u(m,1:n), L_pump/1000, 'b-' ,'linewidth',2);
% legend('\fontsize{12}悬点示功图','\fontsize{12}Gibbs求解方法','\fontsize{12}有限差分法');
% title('\fontsize{15}一级杆油井示功图');
% title('\fontsize{15}三级杆油井示功图');
% xlabel('\fontsize{12}位移 (m)'); ylabel('\fontsize{12}载荷 (kN)');
% xlim([-0.5, 6]);
% grid on; box on;
% hold off;
