function Pro4_1
%功能:计算云图亮温对应的高度层

load('temp3.mat', 't');  %读入温度数据
T=t;
load('IR1_2100.mat', 'bb'); %读入云图数据
I = bb + 1;
[height, width] = size(I);
load('k_temp.mat', 'k_temp'); %读入定标表数据
Table = k_temp;

p = [0.1 0.2 0.5 1 1.5 2 3 4 5 7 10 20 30 50 70 100 150 200 250 300 350 ...
     400 450 500 550 600 650 700 750 800 850 900 925 950 975 1000];

%%%%%灰度值转化为亮温%%%%%
Tb=zeros(height,width);
for i = 1 : height
    for j = 1 : width
        if I(i, j) > 0
            Tb(i, j) = Table(I(i, j));
        end
    end
end
%%%%%灰度值转化为亮温%%%%%

delta = 0.28125; %温度数据中经纬度间隔

longitude = 46 : 126;
latitude = 40 : -1 : -40;
M=size(latitude,2);
N=size(longitude,2);
longitude = repmat(longitude, [M, 1]);   %经度
latitude = repmat(latitude', [1, N]);    %纬度
level = zeros(M, N); %存储各经纬点所在高度层

for i = 1 : M
    for j = 1 : N
        lon = longitude(i, j);
        lat = latitude(i, j);
        lonRad = lon * pi / 180;
        latRad = lat * pi / 180;
        
        %计算该点在云图中的精确位置
        [rowTb, colTb] = iCoordinateProject2(lonRad, latRad);
        %双线性插值得到tb
        x1 = floor(rowTb);
        y1 = floor(colTb);
        x2 = x1 + 1;
        y2 = y1 + 1;
        tb11 = Tb(x1, y1);
        tb12 = Tb(x1, y2);
        tb21 = Tb(x2, y1);
        tb22 = Tb(x2, y2);
        tb1 = (x2 - rowTb) * tb11 + (rowTb - x1) * tb21;
        tb2 = (x2 - rowTb) * tb12 + (rowTb - x1) * tb22;
        tb = (y2 - colTb) * tb1 + (colTb - y1) * tb2;
       
        
        %计算该在温度数据中的精确位置
        lon2 = lon;
        lat2 = 90 - lat;
        if lon2 < 0 
            lon2 = lon2 + 360;
            if lon2 >= 360
                lon2 = 0;
            end
        end      
        colT = lon2 / delta + 1;
        rowT = lat2 / delta + 1;
        x1 = floor(rowT);
        y1 = floor(colT);
        x2 = x1 + 1;
        y2 = y1 + 1;
        
        t = zeros(36,1);
        for k = 1 : 36
            %双线性插值得到t(k)       
            t11 = T(x1, y1, k);
            t12 = T(x1, y2, k);
            t21 = T(x2, y1, k);
            t22 = T(x2, y2, k);
            t1 = (x2 - rowT) * t11 + (rowT - x1) * t21;
            t2 = (x2 - rowT) * t12 + (rowT - x1) * t22;
            t(k) = (y2 - colT) * t1 + (colT - y1) * t2;
        end
        
        %判断云图介于哪两层之间
        if tb > t(36)
            level(i, j) = 1000;
            continue;
        end    
        for h = 35 : -1 : 1
            if tb > t(h)
                break;
            end
        end
        
        level(i, j) = p(h) + (tb - t(h)) * (p(h + 1) - p(h)) / (t(h + 1) -t(h));
    end
end

%保存数据
 save('longitude.mat','longitude');
 save('latitude.mat','latitude');
 save('level.mat','level');


function [row, col] = iCoordinateProject2(lon, lat)
%功能:已知经纬度坐标(弧度)求图像坐标row、col(未取整）

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
row = vAngle * 1000000 / 140;
hAngle = asin(P(2) / sqrt(P(1)^2 + P(2)^2));
col = hAngle * 1000000 / 140;
row = center - row;
col = center + col;



