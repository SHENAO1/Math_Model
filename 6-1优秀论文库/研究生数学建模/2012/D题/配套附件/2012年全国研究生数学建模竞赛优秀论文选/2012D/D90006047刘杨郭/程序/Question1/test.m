function test 

longitude = 46 : 126;
latitude = 40 : -1 : -40;
M = size(latitude,2);
N = size(longitude,2);
longitude = repmat(longitude, [M, 1]);
latitude = repmat(latitude', [1, N]);

cols = zeros(M, N);
rows = zeros(M, N);
lons = zeros(M, N);
lats = zeros(M, N);

for i = 1 : M
    for j = 1 : N
        lon = longitude(i, j);
        lon = lon * pi / 180;
        lat = latitude(i, j);
        lat = lat * pi /180;
        [row, col] = iCoordinateProject(lon, lat);  
        rows(i, j) = row;
        cols(i, j) = col;
        [lon1, lat1] = CoordinateProject(row, col);
        lon1 = lon1 * 180 / pi;
        lat1 = lat1 * 180 / pi;
        lons(i, j) = lon1;
        lats(i, j) = lat1;
    end
end

disp('success!!');