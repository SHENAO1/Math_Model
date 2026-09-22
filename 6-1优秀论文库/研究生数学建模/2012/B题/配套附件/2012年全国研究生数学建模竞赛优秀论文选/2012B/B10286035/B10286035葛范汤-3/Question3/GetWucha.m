function Wucha = GetWucha( Pin)
load('meadata_09_00')
Wucha=0;
GM=3.986005*10^14;
t=meadata_09_00(1:600,1);
Refer=Pin;
xout=Refer(1:600,1);
yout=Refer(1:600,2);
zout=Refer(1:600,3);
px=polyfit(t,xout,4);
py=polyfit(t,yout,4);
pz=polyfit(t,zout,4);

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
pout=0;

for j=50:170;
    pout(1,j)=sqrt(Trans(dprsquare,j))*Trans(ddpx,j)/Trans(dpx,j);
    pout(1,j)=pout(1,j)+GM*Trans(px,j)/Trans(dpx,j)/Trans(prsquare,j)*sqrt(Trans(dprsquare,j)/Trans(prsquare,j));
end
for j=50:170;
    pout(2,j)=sqrt(Trans(dprsquare,j))*Trans(ddpy,j)/Trans(dpy,j);
    pout(2,j)=pout(2,j)+GM*Trans(py,j)/Trans(dpy,j)/Trans(prsquare,j)*sqrt(Trans(dprsquare,j)/Trans(prsquare,j));
end
for j=50:170;
    pout(3,j)=sqrt(Trans(dprsquare,j))*Trans(ddpz,j)/Trans(dpz,j);
    pout(3,j)=pout(3,j)+GM*Trans(pz,j)/Trans(dpz,j)/Trans(prsquare,j)*sqrt(Trans(dprsquare,j)/Trans(prsquare,j));
end

for j=50:170;
    pout(4,j)=(pout(1,j)+pout(2,j)+pout(3,j))/3;
end;
temp=0;
for j=5:17;
    temp=temp+(pout(1,j*10)-pout(4,j*10))^2+(pout(2,j*10)-pout(4,j*10))^2+(pout(3,j*10)-pout(4,j*10))^2;
end
Wucha=temp;

    


end

