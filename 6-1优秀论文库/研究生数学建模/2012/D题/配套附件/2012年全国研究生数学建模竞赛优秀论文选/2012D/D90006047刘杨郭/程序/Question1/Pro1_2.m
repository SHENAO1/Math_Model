function Pro1_2
%功能：在卫星云图上叠加海岸线

load('IR1_2030.mat','aa');       %读取圆盘图
aa = mat2gray(aa);
I(:,:,1) = aa;
I(:,:,2) = aa;
I(:,:,3) = aa;

load('coastline0.mat','data');   %读取海岸线

j = 0;
k = 0;
[M, N] = size(data);
while(k<M)
    k = k + 1;
    lon = data(k, 1) * pi / 180;
    lat = data(k, 2) * pi / 180;
    
    if lon > pi 
        [PP, nP] = InitEdge(BP, j);   %用bresenham对点集插值
        
        for i = 1 : nP                    %绘制边界
            I(PP(i, 1), PP(i, 2), 1) = 255;
            I(PP(i, 1), PP(i, 2), 2) = 0;
            I(PP(i, 1), PP(i, 2), 3) = 0;
        end
        
        j=0;
        continue;
    end
    
    [row, col] = iCoordinateProject(lon, lat);   %计算经纬坐标对应的图像坐标
    j = j + 1;
    BP(j, 1) = row;
    BP(j, 2) = col;
end

[PP,nP] = InitEdge(BP, j);        %用bresenham对点集插值

for i = 1 : nP                    %绘制边界
    I(PP(i, 1), PP(i, 2), 1) = 255;
    I(PP(i, 1) ,PP(i, 2), 2) = 0;
    I(PP(i, 1) ,PP(i, 2), 3) = 0;
end

imwrite(I, 'spic.jpg');



