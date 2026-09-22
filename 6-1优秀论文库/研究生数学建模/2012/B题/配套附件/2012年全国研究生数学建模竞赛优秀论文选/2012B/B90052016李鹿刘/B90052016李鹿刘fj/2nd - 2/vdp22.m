function fy=vdp22(t,x,xcoff,ycoff,zcoff)
gm=3.986005e14;
F=funF2(xcoff,ycoff,zcoff,t);
fy=inv(F)*[x(2) gm*x(1)/norm(x(1:2:5))^3 x(4) gm*x(3)/norm(x(1:2:5))^3 x(6) gm*x(5)/norm(x(1:2:5))^3]';