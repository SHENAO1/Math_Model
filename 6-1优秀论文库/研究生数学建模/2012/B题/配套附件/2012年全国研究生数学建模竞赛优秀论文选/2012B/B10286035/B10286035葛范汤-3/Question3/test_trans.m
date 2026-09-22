P = [10 10 10]';
T = TransCS(P);

x = [10 0 0 1]';
y = [0 10 0 1]';
z = [0 0 10 1]';

modianX = T*x;
dx = [P modianX(1:3)];
modianY = T*y;
dy = [P modianY(1:3)];
modianZ = T*z;
dz = [P modianZ(1:3)];

[XE, YE, ZE] = sphere(10);
RE = sqrt(sum(P.^2));
XE = RE*XE;
YE = RE*YE;
ZE = RE*ZE;
mesh(XE, YE, ZE)
hold on

plot3(dx(1,:), dx(2,:), dx(3,:), 'r','Linewidth', 2);
plot3(dy(1,:), dy(2,:), dy(3,:), 'g','Linewidth', 2);
plot3(dz(1,:), dz(2,:), dz(3,:), 'b','Linewidth', 2);
