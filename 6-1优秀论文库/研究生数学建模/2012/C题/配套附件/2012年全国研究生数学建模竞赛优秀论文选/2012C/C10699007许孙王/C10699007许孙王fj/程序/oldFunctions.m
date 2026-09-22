
Displacement_A = inline('a./b.* r.*(1-cos(theta))', 'a','b','l','r','w','theta');
Velocity_A = inline('a./b.* w.*r.*sin(theta)', 'a','b','l','r','w','theta');
Acceleration_A = inline('a./b.* w.*w.*r.*cos(theta)', 'a','b','l','r','w','theta');

Displacement_B = inline('a./b.* r.*(1-cos(theta)+r./(2.*l).*(sin(theta)).^2)', 'a','b','l','r','w','theta');
Velocity_B = inline('a./b.* w.*r.*(sin(theta)+r./(2.*l).*sin(2.*theta))', 'a','b','l','r','w','theta');
Acceleration_B = inline('a./b.* w.*w.*r./l.*(cos(theta)+r.*cos(2.*theta))', 'a','b','l','r','w','theta');
