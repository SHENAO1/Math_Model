function [dx, dy] = calcWind(I, Ig, J, Jg, x, y, d1, d2)
%功能:计算图像移动的像素点个数
%参数：
%     I:当前时刻云图
%     Ig:I灰度梯度的模
%     J：下一时刻云图
%     Jg:J灰度梯度的模
%     x:示踪云中心所在列
%     y:示踪云中心所在行
%     d1:模板宽度/2
%     d1:搜索区宽度/2
%输出:
%    dx:示踪云在水平方向移动的像素个数，向右为正值
%    dy:示踪云在垂直方向移动的像素个数，向下为正值

%初始化变量
maxCC = 0;
dx = 0;
dy = 0;

%云检测:如果9*9范围内灰度平均值<100，则视为无云区，不做处理.
meanI = mean(mean(I(y - 4 : y + 4, x - 4 : x + 4)));
if meanI < 100
    return;
end

%示踪云块
I1 = I(y - d1 : y + d1 - 1, x - d1 : x + d1 -1);
I1g = Ig(y - d1 : y + d1 - 1, x - d1 : x + d1 -1);

%滑动搜索最大相关系数
d = d2 - d1;
for i = -d : d
    for j = -d : d
        
        J1 = J(y + i - d1 : y + i + d1 -1,x + j -d1 : x + j + d1 - 1);%待匹配云块
        J1g = Jg(y + i - d1 : y + i + d1 -1,x + j -d1 : x + j + d1 - 1);

        cc = CrossCorrelation(I1, I1g, J1, J1g);
        if cc > maxCC
            maxCC = cc;
            dx = j;
            dy = i;
        end
    end
end
