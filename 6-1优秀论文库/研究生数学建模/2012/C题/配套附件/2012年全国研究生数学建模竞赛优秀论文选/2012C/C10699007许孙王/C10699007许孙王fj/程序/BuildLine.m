function line = BuildLine(point, vec)

x0 = point(1); y0 = point(2);
a = vec(1); b = vec(2);

line = [b, -a, a*y0-b*x0];

end