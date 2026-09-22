function [ ds ] = Daoshu( y, dx )

    y = y(1:end);
    ds = ones(1, length(y));
    for i = 2:length(y)-1
        ds(i) = (y(i+1) - y(i-1)) / (2*dx);
    end
    ds(1) = (y(2) - y(1)) / (dx);
    ds(end) = (y(end) - y(end-1)) / (dx);

end
