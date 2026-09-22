function result = Entropy(I)
I = I + 1;
[M, N] = size(I);
temp = zeros(1,256);
for m = 1 : M
    for n = 1 : N
        index = I(m, n);
        temp(index) = temp(index) + 1;
    end
end

temp = temp ./ (M*N);
result = 0;
for i= 1 : 256
    if temp(i) ~= 0
        result = result - temp(i) * log2(temp(i));
    end
end