% load ('PM_ploy')
load ('target_step1')
load('meadata_09_00')
GM=3.986005*10^14;
t=meadata_09_00(1:600,1);
Refer=final;
xout=Refer(1:600,1);
yout=Refer(1:600,2);
zout=Refer(1:600,3);
px=polyfit(t,xout,6);
py=polyfit(t,yout,6);
pz=polyfit(t,zout,6);

pxsquare=conv(px,px);
pysquare=conv(py,py);
pzsquare=conv(pz,pz);
prsquare=pxsquare+pysquare+pzsquare;

dpx=polyder(px);
dpy=polyder(py);
dpz=polyder(pz);

dpxsquare=conv(dpx,dpx);
dpysquare=conv(dpy,dpy);
dpzsquare=conv(dpz,dpz);
dprsquare=dpxsquare+dpysquare+dpzsquare;

ddpx=polyder(dpx);
ddpy=polyder(dpy);
ddpz=polyder(dpz);
kout=0;

for j=50:170;
    kout(1,j)=sqrt(polyval(dprsquare,j))*polyval(ddpx,j)/polyval(dpx,j);
    kout(1,j)=kout(1,j)+GM*polyval(px,j)/polyval(dpx,j)/polyval(prsquare,j)*sqrt(polyval(dprsquare,j)/polyval(prsquare,j));
%     kout(1,j)=sqrt(Trans(dprsquare,j))*Trans(ddpx,j)/Trans(dpx,j);
%     kout(1,j)=kout(1,j)+GM*Trans(px,j)/Trans(dpx,j)/Trans(prsquare,j)*sqrt(Trans(dprsquare,j)/Trans(prsquare,j));
end
for j=50:170;
    kout(2,j)=sqrt(polyval(dprsquare,j))*polyval(ddpy,j)/polyval(dpy,j);
    kout(2,j)=kout(2,j)+GM*polyval(py,j)/polyval(dpy,j)/polyval(prsquare,j)*sqrt(polyval(dprsquare,j)/polyval(prsquare,j));
%     kout(2,j)=sqrt(Trans(dprsquare,j))*Trans(ddpy,j)/Trans(dpy,j);
%     kout(2,j)=kout(2,j)+GM*Trans(py,j)/Trans(dpy,j)/Trans(prsquare,j)*sqrt(Trans(dprsquare,j)/Trans(prsquare,j));
end
for j=50:170;
    kout(3,j)=sqrt(polyval(dprsquare,j))*polyval(ddpz,j)/polyval(dpz,j);
    kout(3,j)=kout(3,j)+GM*polyval(pz,j)/polyval(dpz,j)/polyval(prsquare,j)*sqrt(polyval(dprsquare,j)/polyval(prsquare,j));
%     kout(3,j)=sqrt(Trans(dprsquare,j))*Trans(ddpz,j)/Trans(dpz,j);
%     kout(3,j)=kout(3,j)+GM*Trans(pz,j)/Trans(dpz,j)/Trans(prsquare,j)*sqrt(Trans(dprsquare,j)/Trans(prsquare,j));
end

for j=50:170;
    kout(4,j)=(kout(1,j)+kout(2,j)+kout(3,j))/3;
end;
i=50:1:170;
plot(i,kout(1,50:170),'r');
hold on;
plot(i,kout(2,50:170),'b');
hold on;
plot(i,kout(3,50:170),'g');
hold on;
plot(i,kout(4,50:170),'y');
save kout kout;





