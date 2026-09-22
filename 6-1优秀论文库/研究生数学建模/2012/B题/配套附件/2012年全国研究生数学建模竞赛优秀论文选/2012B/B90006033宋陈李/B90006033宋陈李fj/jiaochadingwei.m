clear
%% 数据输入
A=importdata('meadata_06_00.txt');
B=importdata('meadata_09_00.txt');
n=1;
T=50:169;
x=1:120;
for i=1:5:length(A)
    t(n)=49+n;
    a01(n)=sum(A(i,2)+A(i+1,2)+A(i+2,2)+A(i+3,2)+A(i+4,2))/5;
    b01(n)=sum(A(i,3)+A(i+1,3)+A(i+2,3)+A(i+3,3)+A(i+4,3))/5;
    a02(n)=sum(B(i,2)+B(i+1,2)+B(i+2,2)+B(i+3,2)+B(i+4,2))/5;
    b02(n)=sum(B(i,3)+B(i+1,3)+B(i+2,3)+B(i+3,3)+B(i+4,3))/5;
    n=n+1;
end
C=importdata('sight.txt');
s6(:,1)=C(:,1);s6(:,2)=C(:,2);s6(:,3)=C(:,3);
s9(:,1)=C(:,7);s9(:,2)=C(:,8);s9(:,3)=C(:,9);
%% 坐标变换
for i=1:length(t)
    OX=[s6(i,1),s6(i,2),s6(i,3)];
    IX=OX/norm(OX);
    OZ=cross(OX,cross([0,0,1],OX));
    IZ=OZ/norm(OZ);
    OY=cross(OZ,OX);
    IY=OY/norm(OY);
    a1(i)=-5000000*(IX(1)+IY(1)*a01(i)+IZ(1)*b01(i))+s6(i,1);
    b1(i)=-5000000*(IX(2)+IY(2)*a01(i)+IZ(2)*b01(i))+s6(i,2);
    c1(i)=-5000000*(IX(3)+IY(3)*a01(i)+IZ(3)*b01(i))+s6(i,3);
end
for i=1:length(t)
    OX=[s9(i,1),s9(i,2),s9(i,3)];
    IX=OX/norm(OX);
    OZ=cross(OX,cross([0,0,1],OX));
    IZ=OZ/norm(OZ);
    OY=cross(OZ,OX);
    IY=OY/norm(OY);
    a2(i)=-5000000*(IX(1)+IY(1)*a02(i)+IZ(1)*b02(i))+s9(i,1);
    b2(i)=-5000000*(IX(2)+IY(2)*a02(i)+IZ(2)*b02(i))+s9(i,2);
    c2(i)=-5000000*(IX(3)+IY(3)*a02(i)+IZ(3)*b02(i))+s9(i,3);
end
%% 观测卫星及其方位测量
hold on
for i=1:10:length(s9)
    plot3([s9(i,1),a2(i)],[s9(i,2),b2(i)],[s9(i,3),c2(i)],'m');
    plot3(s9(i,1),s9(i,2),s9(i,3),'m^');
end
for i=1:10:length(s6)
    plot3([s6(i,1),a1(i)],[s6(i,2),b1(i)],[s6(i,3),c1(i)],'r');
    plot3(s6(i,1),s6(i,2),s6(i,3),'r^');
end
%% 求公垂线中点
for i=1:length(t)
    f1=[a1(i)-s6(i,1),b1(i)-s6(i,2),c1(i)-s6(i,3)];
    f2=[a2(i)-s9(i,1),b2(i)-s9(i,2),c2(i)-s9(i,3)];
    n=cross(f1,f2);
    n=n/norm(n);
    S1S2=[s9(i,1)-s6(i,1),s9(i,2)-s6(i,2),s9(i,3)-s6(i,3)];
    MN(i,:)=dot(S1S2,n)*n;
    OS1=[s6(i,1),s6(i,2),s6(i,3)]+MN(i);
    f3=OS1-[s9(i,1),s9(i,2),s9(i,3)];
    sinN=norm(cross(f1,f2))/(norm(f1)*norm(f2));
    sinS1=norm(cross(f1,f3))/(norm(f1)*norm(f3));
    sinS2=norm(cross(f2,f3))/(norm(f2)*norm(f3));
    S1M=norm(f3)*sinS2/sinN/norm(f1)*f1;
    S2N=norm(f3)*sinS1/sinN/norm(f2)*f2;
    OM(i,:)=[s6(i,1),s6(i,2),s6(i,3)]+S1M;
    ON(i,:)=[s9(i,1),s9(i,2),s9(i,3)]+S2N;
    OF(i,:)=(OM(i,:)+ON(i,:))/2;
    fx(i)=OF(i,1);fy(i)=OF(i,2);fz(i)=OF(i,3);
end
plot3(fx,fy,fz,'bo-');
r=(fx.^2+fy.^2+fz.^2).^(1/2);
%% 随机误差分析
for i=1:120 l0(i)=norm(MN(i,:));end
for i=1:120 l6(i)=norm(s6(i,:)-OM(i,:));end
for i=1:120 l9(i)=norm(s9(i,:)-ON(i,:));end

%% 计算卫星测量偏角
for i=1:120 a(i)=norm(OM(i,:)-OF(i,:))/norm(s6(i,:)-OM(i,:));end
plot(a);
for i=1:120 b(i)=norm(ON(i,:)-OF(i,:))/norm(s9(i,:)-ON(i,:));end
plot(b);

%% 反坐标变换
for i=1:length(t)
    OX=[s6(i,1),s6(i,2),s6(i,3)];
    IX=OX/norm(OX);
    OZ=cross(OX,cross([0,0,1],OX));
    IZ=OZ/norm(OZ);
    OY=cross(OZ,OX);
    IY=OY/norm(OY);
    Q=[IX(1),IY(1),IZ(1)
       IX(2),IY(2),IZ(2)
       IX(3),IY(3),IZ(3)];
    Ms1(i,:)=(inv(Q)*(OM(i,:)-s6(i,:))')';
    Ms1(i,:)=Ms1(i,:)/Ms1(i,1);
    Ns1(i,:)=(inv(Q)*(ON(i,:)-s6(i,:))')';
    Ns1(i,:)=Ns1(i,:)/Ns1(i,1);
    Fs1(i,:)=(inv(Q)*(OF(i,:)-s6(i,:))')'; 
    Fs1(i,:)=Fs1(i,:)/Fs1(i,1);
end
for i=1:length(t)
    OX=[s9(i,1),s9(i,2),s9(i,3)];
    IX=OX/norm(OX);
    OZ=cross(OX,cross([0,0,1],OX));
    IZ=OZ/norm(OZ);
    OY=cross(OZ,OX);
    IY=OY/norm(OY);
    Q=[IX(1),IY(1),IZ(1)
       IX(2),IY(2),IZ(2)
       IX(3),IY(3),IZ(3)];
    Ns2(i,:)=(inv(Q)*(ON(i,:)-s9(i,:))')';
    Ms2(i,:)=(inv(Q)*(OM(i,:)-s9(i,:))')';
    Ms2(i,:)=Ms2(i,:)/Ms2(i,1);
    Ns2(i,:)=Ns2(i,:)/Ns2(i,1);
    Fs2(i,:)=(inv(Q)*(OF(i,:)-s9(i,:))')';  
    Fs2(i,:)=Fs2(i,:)/Fs2(i,1);
end

%% 三轴指向误差分析
da1=(Ms1(:,2)-Fs1(:,2))';
db1=(Ms1(:,3)-Fs1(:,3))';
de1=(Ms1(:,2)'.*db1-Ms1(:,3)'.*da1)./sqrt(Ms1(:,2)'.^2+Ms1(:,3)'.^2);
da2=(Ns2(:,2)-Fs2(:,2))';
db2=(Ns2(:,3)-Fs2(:,3))';
de2=(Ns2(:,2)'.*db2-Ns1(:,3)'.*da2)./sqrt(Ns2(:,2)'.^2+Ns2(:,3)'.^2);
p1=polyfit(T,da1,1);d1=polyval(p1,T);
p2=polyfit(T,db1,1);d2=polyval(p2,T);
p3=polyfit(T,da2,1);d3=polyval(p3,T);
p4=polyfit(T,db2,1);d4=polyval(p4,T);
p5=polyfit(T,de1,1);d5=polyval(p5,T);
p6=polyfit(T,de2,1);d6=polyval(p6,T);
k1=p1(1);k2=p2(1);k3=p3(1);k4=p4(1);k5=p5(1);k6=p6(1);
hold off
plot(T,da1);hold on;plot(T,db1);plot(T,da2);plot(T,db2);plot(T,de1);plot(T,de2);
plot(T,d1);plot(T,d2);plot(T,d3);plot(T,d4);plot(T,d5);plot(T,d6);

%% 系统误差评估
W=inf;
for u=0:0.01:1
    for v=0:0.01:1
        for i=1:length(OF)
            v0=(1-i/120)*u+i/120*v;
            OF(i,:)=(1-v0)*OM(i,:)+v0*ON(i,:);
            OX=[s6(i,1),s6(i,2),s6(i,3)];
            IX=OX/norm(OX);
            OZ=cross(OX,cross([0,0,1],OX));
            IZ=OZ/norm(OZ);
            OY=cross(OZ,OX);
            IY=OY/norm(OY);
            Q=[IX(1),IY(1),IZ(1)
               IX(2),IY(2),IZ(2)
               IX(3),IY(3),IZ(3)];
            Fs1(i,:)=(inv(Q)*(OF(i,:)-s6(i,:))')'; 
            Fs1(i,:)=Fs1(i,:)/Fs1(i,1);
            OX=[s9(i,1),s9(i,2),s9(i,3)];
            IX=OX/norm(OX);
            OZ=cross(OX,cross([0,0,1],OX));
            IZ=OZ/norm(OZ);
            OY=cross(OZ,OX);
            IY=OY/norm(OY);
            Q=[IX(1),IY(1),IZ(1)
               IX(2),IY(2),IZ(2)
               IX(3),IY(3),IZ(3)];
            Fs2(i,:)=(inv(Q)*(OF(i,:)-s9(i,:))')';  
            Fs2(i,:)=Fs2(i,:)/Fs2(i,1);
        end
        da1=(Ms1(:,2)-Fs1(:,2))';
        db1=(Ms1(:,3)-Fs1(:,3))';
        de1=(Ms1(:,2)'.*db1-Ms1(:,3)'.*da1)./sqrt(Ms1(:,2)'.^2+Ms1(:,3)'.^2);
        da2=(Ns2(:,2)-Fs2(:,2))';
        db2=(Ns2(:,3)-Fs2(:,3))';
        de2=(Ns2(:,2)'.*db2-Ns1(:,3)'.*da2)./sqrt(Ns2(:,2)'.^2+Ns2(:,3)'.^2);
        p1=polyfit(T,da1,1);d1=polyval(p1,T);
        p2=polyfit(T,db1,1);d2=polyval(p2,T);
        p3=polyfit(T,da2,1);d3=polyval(p3,T);
        p4=polyfit(T,db2,1);d4=polyval(p4,T);
        p5=polyfit(T,de1,1);d5=polyval(p5,T);
        p6=polyfit(T,de2,1);d6=polyval(p6,T);
        k1=p1(1);k2=p2(1);k3=p3(1);k4=p4(1);k5=p5(1);k6=p6(1);
        w0=abs(k1)+abs(k2)+abs(k3)+abs(k4);%+abs(k5)+abs(k6);
        %w0=k1^2+k2^2+k3^2+k4^2;
        if w0<W
            W=w0;U=u;V=v;end
    end
end
