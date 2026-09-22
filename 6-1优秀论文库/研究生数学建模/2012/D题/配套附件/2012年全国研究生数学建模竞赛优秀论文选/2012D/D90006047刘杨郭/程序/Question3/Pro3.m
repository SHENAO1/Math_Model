function Pro3
%功能：根据三幅连续云图，利用MCC方法计算云迹风,自适应窗口

tic;

% templateSize = 32; %示踪云块大小
theta = 86.5 * pi / 180; %星下点经度
a = 6378136.5;        %长半轴
b = 6356751;          %短半轴

%读入三幅连续云图
I0 = imread('aa.bmp');
I1 = imread('bb.bmp');
I2 = imread('cc.bmp');
%求云图梯度
[I0gx, I0gy] = gradient(double(I0));
[I1gx, I1gy] = gradient(double(I1));
[I2gx, I2gy] = gradient(double(I2));
I0g = sqrt(I0gx.^2 + I0gy.^2);
I1g = sqrt(I1gx.^2 + I1gy.^2);
I2g = sqrt(I2gx.^2 + I2gy.^2);

%初始化变量
longitude = 46 : 1 : 126;
latitude = 40 : -1 : -40;
M = size(latitude,2);
N = size(longitude,2);
longitude = repmat(longitude, [M, 1]);
latitude = repmat(latitude', [1, N]);

Dx = zeros(M, N);
Dy = zeros(M, N);
Wind = zeros(M, N);
Direction = zeros(M, N);

rows = zeros(M, N);
cols = zeros(M, N);
count = 0;
for i = 1 : M
    for j = 1 : N
        
        fprintf('总数:%d ', M * N);
        fprintf('正在计算第%d个 ', (i - 1) * N + j);
        fprintf('剩余:%d\n', M * N - (i - 1) * N - j);
        
        %计算经纬坐标对应的图像坐标
        lon1 = longitude(i, j) * pi / 180;
        lat1 = latitude(i, j) * pi / 180;     
        [row, col] = iCoordinateProject(lon1, lat1);   
        
        cols(i, j) = col;
        rows(i, j) = row;

        %计算示踪云在图像上的平移量
        [dx1, dy1] = calcWind(I0, I0g, I1, I1g, col, row);
        [dx2, dy2] = calcWind(I1, I1g, I2, I2g, col, row);

        %根据三幅云的时间连续性进行质量控制：如果两个风矢量的差的模大于两者模的平均，则视为无效;
        mod1 = sqrt(dx1^2 + dy1^2);
        mod2 = sqrt(dx2^2 + dy2^2);
        mod = sqrt((dx1 - dx2)^2 + (dy1 - dy2)^2);
        if mod > (mod1 + mod2) / 2
            continue;
        end

        Dx(i,j) = dx2;
        Dy(i,j) = dy2;
        
        %计算示踪云下一时刻经纬坐标
        [lon2, lat2] = CoordinateProject(row + dy2, col + dx2);
        
        
        %%%%计算风速%%%%
        r1 = sqrt((a * cos(lat1))^2 + (b * sin(lat1))^2);
        x1 = r1 * cos(lat1) * cos(theta - lon1);
        y1 = r1 * cos(lat1) * sin(theta - lon1);
        z1 = r1 * sin(lat1);
        
        r2 = sqrt((a * cos(lat2))^2 + (b * sin(lat2))^2);
        x2 = r2 * cos(lat2) * cos(theta - lon2);
        y2 = r2 * cos(lat2) * sin(theta - lon2);
        z2 = r2 * sin(lat2);
        
        Wind(i, j) = sqrt((x1 - x2)^2 + (y1 - y2)^2 + (z1 - z2)^2) / 1800;
        
        
        %%%%计算风向%%%%
        if lon1 > lon2
            direct = acos((lat1 - lat2) / sqrt((lon2 - lon1)^2 + (lat2 - lat1)^2));
        else
            direct = pi +  acos((lat2 - lat1) / sqrt((lon2 - lon1)^2 + (lat2 - lat1)^2));
        end        
        Direction(i, j) = direct * 180 / pi;
        
        count = count + 1;
    end
end

 Wind1 = Wind;
 Direction1 = Direction;
 for i = 2 : M - 1
     for j = 2 : N - 1
         %空间连续性质量控制：对每一个风矢量检验与周围风是否有连续性;
         meanDir = (Direction(i - 1, j) + Direction(i + 1, j) + Direction(i, j - 1) + Direction(i, j + 1)) / 4;
         meanWind = (Wind(i - 1, j) + Wind(i + 1, j) + Wind(i, j - 1) + Wind(i, j + 1)) / 4;
         if abs(Direction(i, j) - meanDir) > 90 || abs(Wind(i, j) - meanWind) > 80
%          if abs(Wind(i, j) - meanWind) > 30
             Wind1(i, j) = 0;
             Direction(i, j) = 0;
             Dx(i, j) = 0;
             Dy(i, j) = 0;
             count = count - 1;
         end
     end
 end
 
 Wind = Wind1;
 Direction = Direction1;
 
 time = toc;

save('results/longitude.mat', 'longitude');
save('results/latitude.mat', 'latitude');
save('results/Wind.mat', 'Wind');
save('results/Direction.mat', 'Direction');
save('results/Dx.mat', 'Dx');
save('results/Dy.mat', 'Dy');
save('results/cols.mat', 'cols');
save('results/rows.mat', 'rows');
save('results/count.mat', 'count');

% 
% %提取并保存计算范围云图子图
% minCol = min(min(cols)) - 10;
% maxCol = max(max(cols)) + 10;
% minRow = min(min(rows)) - 10;
% maxRow = max(max(rows)) + 10;
% imwrite(I0(minRow : maxRow, minCol : maxCol), '0.bmp');
% imwrite(I1(minRow : maxRow, minCol : maxCol), '1.bmp');
% imwrite(I2(minRow : maxRow, minCol : maxCol), '2.bmp');
% 
% %在云图上绘制矢量风场
% imshow(I1);
% hold on;
% quiver(cols,rows,Dx,Dy);
% hold off;



