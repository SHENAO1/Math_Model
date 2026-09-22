%% 数据
peaks;
peaks_u;
peaks_F;

%% 
corner{1} = [0 0];
corner{2} = [0 1];
corner{3} = [1 1];
corner{4} = [1 0];

%% 自动提取A,B,C,D
len = length(peaks);
indexes = [-1 -1 -1 -1];
n_got = 0;
for i = 1:4
    mindist = inf;
    minj = [];
    for j = 1:len
        point = [peaks_u(j), peaks_F(j)];
        dist = sum((point-corner{i}).^2);
        if dist < mindist
            mindist = dist;
            minj = j;
        end
    end
    indexes(i) = minj;
end

index_A = peaks(indexes(1));   % A,B,C,D四点的标号
index_B = peaks(indexes(2));
index_C = peaks(indexes(3));
index_D = peaks(indexes(4));

PointA = [peaks_u(indexes(1)), peaks_F(indexes(1))];
PointB = [peaks_u(indexes(2)), peaks_F(indexes(2))];
PointC = [peaks_u(indexes(3)), peaks_F(indexes(3))];
PointD = [peaks_u(indexes(4)), peaks_F(indexes(4))];

