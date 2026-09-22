function [dx, dy] = calcWind(I, Ig, J, Jg, x, y)
%功能:计算图像移动的像素点个数
%参数：
%     I:当前时刻云图
%     Ig:I灰度梯度的模
%     J：下一时刻云图
%     Jg:J灰度梯度的模
%     x:示踪云中心所在列
%     y:示踪云中心所在行
%输出:
%    dx:示踪云在水平方向移动的像素个数，向右为正值
%    dy:示踪云在垂直方向移动的像素个数，向下为正值

%初始化变量
maxMI = 0;
dx = 0;
dy = 0;

%云检测:如果9*9范围内灰度平均值<100，则视为无云区，不做处理.
meanI = mean(mean(I(y - 4 : y + 4, x - 4 : x + 4)));
if meanI < 100
    return;
end

d0 = 16;
d = 0;
entropy = 0;
for i = 1 : 16
    d1 = d0 + i;
    I1 = I(y - d1 : y + d1 - 1, x - d1 : x + d1 -1);
    entropy1 = Entropy(I1);
    if entropy1 > entropy
        entropy = entropy1;
        d = i;
    end
end

% d1 = 32;
d1 = d0 + d;
d2 = d1 + 32;
fprintf('窗口大小:%d*%d\n', d1,d1);

%示踪云块
I1 = I(y - d1 : y + d1 - 1, x - d1 : x + d1 -1);
I1g = Ig(y - d1 : y + d1 - 1, x - d1 : x + d1 -1);


step = 1;
%滑动搜索最大相关系数
d = d2 - d1;
for i = -d : step : d
    for j = -d : step : d
        
        J1 = J(y + i - d1 : y + i + d1 -1,x + j -d1 : x + j + d1 - 1);%待匹配云块
        J1g = Jg(y + i - d1 : y + i + d1 -1,x + j -d1 : x + j + d1 - 1);
%         mi = MI(I1, J1);
        mi = CrossCorrelation(I1, I1g, J1, J1g);
        if mi > maxMI
            maxMI = mi;
            dx = j;
            dy = i;
        end
    end
end

% maxMI=0;
% for i = -step : step
%     for j = -step : step
%         
%         J1 = J(y + dy + i - d1 : y + dy + i + d1 -1,x + dx + j -d1 : x + dx + j + d1 - 1);%待匹配云块
%         J1g = Jg(y + i - d1 : y + i + d1 -1,x + j -d1 : x + j + d1 - 1);
%         mi = CrossCorrelation(I1, I1g, J1, J1g);
%         if mi > maxMI
%             maxMI = mi;
%             dx = dx + j;
%             dy = dy + i;
%         end
%     end
% end



