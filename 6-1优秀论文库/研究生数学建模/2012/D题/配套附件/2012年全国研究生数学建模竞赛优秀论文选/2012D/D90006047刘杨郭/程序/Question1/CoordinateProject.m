function [lon, lat] = CoordinateProject(row, col)
%功能:根据图像坐标row、col求经纬度坐标(弧度)

h = 42164000;         %卫星球心距离
theta1 = 86.5 * pi / 180; %星下点经度
a = 6378136.5;        %长半轴
b = 6356751;          %短半轴
center = 1145;        %星下点在矩阵中位置

T = [-1 0 0 0;        %坐标转换矩阵
     0 -1 0 0;
     0 0 1 0;
     h 0 0 1];

vAngle = (center - row) * 140 / 1000000;      
hAngle = (col - center) * 140 / 1000000;

[minfx, x] = GoldSectionOptimize(a, b, h, hAngle, vAngle, h-a, h);

% y = x * sin(hAngle) / sqrt(1 - (sin(vAngle))^2 - (sin(hAngle))^2);
% z = x * sin(vAngle) / sqrt(1 - (sin(vAngle))^2 - (sin(hAngle))^2);
y = x * tan(hAngle);
z = x * tan(vAngle) / cos(hAngle);
p = [x y z 1] * T;
lat = asin(p(3) / sqrt(p(1)^2 + p(2)^2 + p(3)^2));
lon = theta1 - asin(p(2) / (sqrt(p(1)^2 + p(2)^2 + p(3)^2) * cos(lat)));

function [minfx,x]=GoldSectionOptimize(ra, rb, h, hAngle, vAngle, a, b)

L = 0.000001;

%黄金分割法搜索
landa = a + 0.382 * (b - a);
mu = a + 0.618 * (b - a);
flanda = Fx(landa, ra, rb, h, hAngle, vAngle);
fmu = Fx(mu, ra, rb, h, hAngle, vAngle);

while(1)
    if b - a < L
        x = (b + a) / 2;
        break;
    end
    if flanda > fmu
        flanda = fmu;
        a = landa;
        landa = mu;
        mu = a + 0.618 * (b - a);
        fmu = Fx(mu, ra, rb, h, hAngle, vAngle);
    else
        fmu = flanda;
        b = mu;
        mu = landa;
        landa = a + 0.382 * (b - a);
        flanda = Fx(landa, ra, rb, h, hAngle, vAngle);
    end
end
minfx = Fx(x, ra, rb, h, hAngle, vAngle);  %返回目标函数最小值

function [y] = Fx(x, a, b, h, hAngle, vAngle)
y = (x - h)^2 / a^2 + (x * tan(hAngle))^2 / a^2 + (x * tan(vAngle) / cos(hAngle))^2 / b^2 - 1;
y = abs(y);