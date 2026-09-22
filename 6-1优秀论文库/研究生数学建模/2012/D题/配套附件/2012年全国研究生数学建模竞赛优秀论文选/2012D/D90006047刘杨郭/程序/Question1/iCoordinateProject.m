function [row, col] = iCoordinateProject(lon, lat)
%功能:已知经纬度坐标(弧度)求图像坐标row、col

h = 42164000;         %卫星球心距离
theta1 = 86.5 * pi / 180; %星下点经度
a = 6378136.5;        %长半轴
b = 6356751;          %短半轴
center = 1145;        %星下点在矩阵中位置

T = [-1 0 0 0;        %坐标转换矩阵
     0 -1 0 0;
     0 0 1 0;
     h 0 0 1];

r = sqrt((a * cos(lat))^2 + (b * sin(lat))^2);
x = r * cos(lat) * cos(theta1 - lon);
y = r * cos(lat) * sin(theta1 - lon);
z = r * sin(lat);
P = [x y z 1];
P = P / T;
vAngle = asin(P(3) / sqrt(P(1)^2 + P(2)^2 + P(3)^2));
row = fix(vAngle * 1000000 / 140);
% row = vAngle * 1000000 / 140;
hAngle = asin(P(2) / sqrt(P(1)^2 + P(2)^2));
col = fix(hAngle * 1000000 / 140);
% col = hAngle * 1000000 / 140;
row = center - row;
col = center + col;