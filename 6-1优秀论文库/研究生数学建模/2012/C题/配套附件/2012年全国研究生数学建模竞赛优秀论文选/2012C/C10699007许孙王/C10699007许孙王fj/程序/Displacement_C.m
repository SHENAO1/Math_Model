function [ dis, theta ] = Displacement_C( a,b,l,r,w,phi )

xd = b+r.*cos(phi);
yd = -l-r+r.*sin(phi);
ODsqr = xd.*xd + yd.*yd;

cosBOD = (b^2 + ODsqr - l^2) ./ (2.*b.*sqrt(ODsqr));
cosBOD(cosBOD>1) = 1;
cosBOD(cosBOD<-1) = -1;

BOD = acos( cosBOD );
theta = BOD + atan(yd ./ xd);

dis = -a*theta;

end
