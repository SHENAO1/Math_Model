%2012B2几何定位算法;
%clc;clear;
satinfo=textread('satinfo.txt');
data0600=textread('data0600.txt');
data0900=textread('data0900.txt');

%计算6号卫星位置;
Gm=3.986005*10^14;
r=[];a=[];
r(1,1:6)=satinfo(7,:);
t=0.01;
for i=2:0.18/t
    a(i-1,1:3)=-Gm/(r(i-1,1)^2+r(i-1,2)^2+r(i-1,3)^2)^(3/2)*(r(i-1,1:3));
    r(i,4:6)=r(i-1,4:6)+a(i-1,1:3)*t;
    r(i,1:3)=r(i-1,1:3)+r(i-1,4:6)*t+0.5*a(i-1,1:3)*t^2;
end

t0=0.005444807276;
a(18,1:3)=-Gm/(r(18,1)^2+r(18,2)^2+r(18,3)^2)^(3/2)*(r(18,1:3));
r(19,4:6)=r(18,4:6)+a(18,1:3)*t0;
r(19,1:3)=r(18,1:3)+r(18,4:6)*t0+0.5*a(18,1:3)*t0^2;

r(1,1:6)=r(19,1:6);

t=0.01;
for i=2:180/t;
    a(i-1,1:3)=-Gm/(r(i-1,1)^2+r(i-1,2)^2+r(i-1,3)^2)^(3/2)*(r(i-1,1:3));
    r(i,4:6)=r(i-1,4:6)+a(i-1,1:3)*t;
    r(i,1:3)=r(i-1,1:3)+r(i-1,4:6)*t+0.5*a(i-1,1:3)*t^2;
end
satinfo6=r([50/t+1:0.2/t:170/t],:);

%计算9号卫星位置;
Gm=3.986005*10^14;
r=[];a=[];
r(1,1:6)=satinfo(10,:);
t=0.01;
for i=2:0.19/t;
    a(i-1,1:3)=-Gm/(r(i-1,1)^2+r(i-1,2)^2+r(i-1,3)^2)^(3/2)*(r(i-1,1:3));
    r(i,4:6)=r(i-1,4:6)+a(i-1,1:3)*t;
    r(i,1:3)=r(i-1,1:3)+r(i-1,4:6)*t+0.5*a(i-1,1:3)*t^2;
end

t0=0.001218909269;
a(19,1:3)=-Gm/(r(19,1)^2+r(19,2)^2+r(19,3)^2)^(3/2)*(r(19,1:3));
r(20,4:6)=r(19,4:6)+a(19,1:3)*t0;
r(20,1:3)=r(19,1:3)+r(19,4:6)*t0+0.5*a(19,1:3)*t0^2;

r(1,1:6)=r(20,1:6);

t=0.01;
for i=2:180/t;
    a(i-1,1:3)=-Gm/(r(i-1,1)^2+r(i-1,2)^2+r(i-1,3)^2)^(3/2)*(r(i-1,1:3));
    r(i,4:6)=r(i-1,4:6)+a(i-1,1:3)*t;
    r(i,1:3)=r(i-1,1:3)+r(i-1,4:6)*t+0.5*a(i-1,1:3)*t^2;
end
satinfo9=r([50/t+1:0.2/t:170/t],:);


%经纬度计算;
%6号卫星;
for i=1:600
    if satinfo6(i,2)>=0
        la1(i)=acos(satinfo6(i,1)/(satinfo6(i,1)^2+satinfo6(i,2)^2)^0.5);
    else
        la1(i)=-acos(satinfo6(i,1)/(satinfo6(i,1)^2+satinfo6(i,2)^2)^0.5);
    end
    fa1(i)=atan(satinfo6(i,3)/(satinfo6(i,2)^2+satinfo6(i,1)^2)^0.5);
end   


%9号卫星;
for i=1:600
    if satinfo9(i,2)>=0
        la2(i)=acos(satinfo9(i,1)/(satinfo9(i,1)^2+satinfo9(i,2)^2)^0.5);
    else
        la2(i)=-acos(satinfo9(i,1)/(satinfo9(i,1)^2+satinfo9(i,2)^2)^0.5);
    end
    fa2(i)=atan(satinfo9(i,3)/(satinfo9(i,2)^2+satinfo9(i,1)^2)^0.5);
end

%e,a的计算;
%6号卫星;
a1=[];e1=[];
for i=1:600
    e1(i)=atan(-(data0600(i,2)^2+data0600(i,3)^2)^0.5);
    a1(i)=pi*3/2-atan(data0600(i,3)/data0600(i,2));
end
%9号卫星;
a2=[];e2=[];
for i=1:600
    e2(i)=atan(-(data0900(i,2)^2+data0900(i,3)^2)^0.5);
    a2(i)=pi*3/2-atan(data0900(i,3)/data0900(i,2));
end

%求6号卫星的观测矢量p1;
p1=[];
Mx=[];My=[];%旋转矩阵;
U=[];%单位矢量;
for i=1:600
    Mx=[cos(la1(i)) -sin(la1(i)) 0;sin(la1(i)) cos(la1(i)) 0;0 0 1];
    My=[cos(fa1(i)) 0 -sin(fa1(i));0 1 0;sin(fa1(i)) 0 cos(fa1(i))];
    U=[-cos(e1(i));-sin(a1(i))*sin(e1(i));-cos(a1(i))*sin(e1(i))];
    p1(i,1:3)=Mx*My*U;
end

%求9号卫星的观测矢量p1;
p2=[];
Mx=[];My=[];%旋转矩阵;
U=[];%单位矢量;
for i=1:600
    Mx=[cos(la2(i)) -sin(la2(i)) 0;sin(la2(i)) cos(la2(i)) 0;0 0 1];
    My=[cos(fa2(i)) 0 -sin(fa2(i));0 1 0;sin(fa2(i)) 0 cos(fa2(i))];
    U=[-cos(e2(i));-sin(a2(i))*sin(e2(i));-cos(a2(i))*sin(e2(i))];
    p2(i,1:3)=Mx*My*U;
end


%计算飞行器的位置坐标;
fei0=[];
for i=1:599
    A1=det([p1(i+1,2) p1(i+1,3);p1(i,2) p1(i,3)]);
    B1=det([p1(i+1,3) p1(i+1,1);p1(i,3) p1(i,1)]);
    C1=det([p1(i+1,1) p1(i+1,2);p1(i,1) p1(i,2)]);
    D1=satinfo6(i,1:3)*[-A1;-B1;-C1];
    
    A2=det([p2(i+1,2) p2(i+1,3);p2(i,2) p2(i,3)]);
    B2=det([p2(i+1,3) p2(i+1,1);p2(i,3) p2(i,1)]);
    C2=det([p2(i+1,1) p2(i+1,2);p2(i,1) p2(i,2)]);
    D2=satinfo9(i,1:3)*[-A2;-B2;-C2];
    
    ef=-D1/D2;
    
    A=A1+ef*A2;
    B=B1+ef*B2;
    C=C1+ef*C2;
    
    ro=-(satinfo6(i,1:3))*[A;B;C]/(p1(i,1:3)*[A;B;C]);
    fei0(i,1:3)=satinfo6(i,1:3)+ro*p1(i,1:3);
end
