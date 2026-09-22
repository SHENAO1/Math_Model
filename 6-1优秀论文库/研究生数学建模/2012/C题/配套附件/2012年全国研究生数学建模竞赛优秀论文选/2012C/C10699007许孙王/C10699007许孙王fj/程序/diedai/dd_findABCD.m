%% 数据
peaks;
peaks_u;
peaks_F;

%% 
cornerA = [0 0];
cornerB = [0 1];
cornerC = [1 1];
cornerD = [1 0];

%% 自动提取A,B,C,D
len = length(peaks);
indexes = [-1 -1 -1 -1];
n_got = 0;
for i = 1:len
    point = [peaks_u(i), peaks_F(i)];
    dists(1) = sum((point-cornerA).^2);
    dists(2) = sum((point-cornerB).^2);
    dists(3) = sum((point-cornerC).^2);
    dists(4) = sum((point-cornerD).^2);
    [tmp min_d] = min(dists);
    if (indexes(min_d) < 0)
        indexes(min_d) = i;
        n_got = n_got + 1;
        if n_got == 4
            break;
        end
    end
end

index_A = peaks(indexes(1));   % A,B,C,D四点的标号
index_B = peaks(indexes(2));
index_C = peaks(indexes(3));
index_D = peaks(indexes(4));

PointA = [peaks_u(indexes(1)), peaks_F(indexes(1))];
PointB = [peaks_u(indexes(2)), peaks_F(indexes(2))];
PointC = [peaks_u(indexes(3)), peaks_F(indexes(3))];
PointD = [peaks_u(indexes(4)), peaks_F(indexes(4))];

