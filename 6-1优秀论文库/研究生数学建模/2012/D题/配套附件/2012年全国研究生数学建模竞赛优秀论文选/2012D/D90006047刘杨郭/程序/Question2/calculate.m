k = 0;
for i = 1 : M
    for j = 1 : N
        if windX(i, j) ~= 0 && windY(i, j) ~= 0
            k = k + 1;
        end
    end
end
k;