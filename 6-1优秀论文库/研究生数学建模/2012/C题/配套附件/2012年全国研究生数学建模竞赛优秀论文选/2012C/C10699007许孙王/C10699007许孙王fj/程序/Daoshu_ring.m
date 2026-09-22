function [ ds ] = Daoshu_ring( y, dx )

    y = y(1:end);
    ds = ones(1, length(y));
    for i = 2:length(y)-1
        ds(i) = (y(i+1) - y(i-1)) / (2*dx);
        %ds(i) = (y(i+1) - y(i)) / (dx);        
    end
    ds(1) = (y(2) - y(end)) / (2 .* dx);
    ds(end) = (y(1) - y(end-1)) / (2 .* dx);
%     ds(1) = (y(2) - y(1)) / (dx);
%     ds(end) = (y(end) - y(end-1)) / (dx);
end
