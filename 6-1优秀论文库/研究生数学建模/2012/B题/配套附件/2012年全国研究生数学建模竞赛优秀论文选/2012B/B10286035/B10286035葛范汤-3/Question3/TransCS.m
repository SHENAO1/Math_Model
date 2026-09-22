function Tcs = TransCS(Psat)    % 3*1æÿ’Û  Tcs 4*4

p = Psat(1:3);
r = sqrt(sum(p.^2));
n = p/r;

sgn = sign(Psat(3));
a = [-Psat(1)*sgn; -Psat(2)*sgn; ((r^2)/Psat(3)-Psat(3))*sgn];
ra = sqrt(sum(a.^2));
a = a/ra;

o = cross(a, n);

n(4) = 0;
o(4) = 0;
a(4) = 0;
p(4) = 1;

Tcs = [n, o, a, p];