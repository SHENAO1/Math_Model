function [y trans] = GuiYiHua(x, limit)

if nargin==1
    limit = [0 1];
end
xmax = max(x);
xmin = min(x);
y = (x-xmin) / (xmax-xmin) * (limit(2)-limit(1)) + limit(1);
trans = [(xmax-xmin)/(limit(2)-limit(1)), (xmin)];

end
