function Pro4_2

load('Wind.mat', 'Wind');
load('Direction.mat', 'Direction');
load('longitude.mat', 'longitude');
load('latitude.mat', 'latitude');
load('level.mat', 'level');

[M, N] = size(Wind);

fid = fopen('winsh.txt', 'w');
fprintf(fid, '纬度 经度 角度(北顺) 速度(m/s) 压强(毫巴)\n');

count = 0;
for i = 1 : M
    for j = 1 : N 
        lat = latitude(i, j);
        lon = longitude(i, j);
        dir = Direction(i, j);
        speed = Wind(i, j);
        if speed > 0 
            pressure = level(i, j);
            count = count + 1;
              fprintf(fid, '%.2f %.2f %.2f %.2f %.2f\n', lat, lon, dir, speed, pressure); 
        else
            pressure = 0;
        end
        
      
        
        
    end
end
fclose(fid);
