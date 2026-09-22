function value = evalLine(line, point)

A = line(1);
B = line(2);
C = line(3);
x = point(1);
y = point(2);
value = A*x + B*y + C;

end