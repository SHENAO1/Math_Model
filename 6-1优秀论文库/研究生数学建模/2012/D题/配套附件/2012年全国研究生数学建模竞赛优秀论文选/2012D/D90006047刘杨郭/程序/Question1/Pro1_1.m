function Pro1_1
%功能：计算灰度矩阵元素行列号对应的经纬度坐标

load('IR1_2030.mat','aa');       %读取圆盘图
I = mat2gray(aa);
[M, N] = size(I);

mlat = zeros(M, N);  %初始化经纬坐标
mlon = zeros(M, N);

for i = 451 : 550
    for j = 451 : 550
        
        [lon, lat] = CoordinateProject(i, j);  %计算i,j对应的经纬坐标
        
        mlat(i, j) = 180 * lat / pi;
        mlon(i, j) = 180 * lon / pi;
        
    end
end

fid = fopen('jwd.txt','w');  %写入文本
for i = 451 : 550
    for j = 451 : 550
        fprintf(fid, '%.3f,%.3f ', mlon(i, j), mlat(i, j));
    end
    fprintf(fid, '\n');
end
fclose(fid);