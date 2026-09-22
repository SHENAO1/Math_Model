U;
L;
u_xm;
F_xm;
t;

len = length(t);

figure; hold on;
for i=1:len-1
    plot(U(i:i+1), L(i:i+1)/1000, 'r-' ,'linewidth',2);
    plot(u_xm(i:i+1), F_xm(i:i+1)/1000, '--' ,'linewidth',2);
    legend('悬点示功图', '泵示功图');
    xlabel('位移 (m)'); ylabel('载荷 (kN)');
    title('一级杆油井示功图 (由阻尼因子\gamma计算阻尼系数c)');
    xlim([-0.2, 2.9]);
    ylim([-20, 70]);
    pause(0.01);
end
