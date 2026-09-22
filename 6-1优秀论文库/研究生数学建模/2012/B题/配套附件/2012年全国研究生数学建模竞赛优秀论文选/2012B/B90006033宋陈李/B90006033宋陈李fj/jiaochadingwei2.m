clear
%% 数据输入
A=importdata('meadata_06_00.txt');
B=importdata('meadata_09_00.txt');
n=1;
T=50:169;
x=1:120;
u=0.56;v=0.57;
da1=-5.70669e-004;
db1=-8.99568e-005;
da2= 6.59957e-005;
db2= 2.7599e-004;

for i=1:5:length(A)
    t(n)=49+n;
    a01(n)=sum(A(i,2)+A(i+1,2)+A(i+2,2)+A(i+3,2)+A(i+4,2))/5-da1;
    b01(n)=sum(A(i,3)+A(i+1,3)+A(i+2,3)+A(i+3,3)+A(i+4,3))/5-db1;
    a02(n)=sum(B(i,2)+B(i+1,2)+B(i+2,2)+B(i+3,2)+B(i+4,2))/5-da2;
    b02(n)=sum(B(i,3)+B(i+1,3)+B(i+2,3)+B(i+3,3)+B(i+4,3))/5-db2;
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
%% 求修正后观测点
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
    v0=(1-i/120)*u+i/120*v;
    OF(i,:)=(1-v0)*OM(i,:)+v0*ON(i,:);
    fx(i)=OF(i,1);fy(i)=OF(i,2);fz(i)=OF(i,3);
end
plot3(fx,fy,fz,'bo-');
%% 随机误差分析
for i=1:120 l0(i)=norm(MN(i,:));end
for i=1:120 l6(i)=norm(s6(i,:)-OM(i,:));end
for i=1:120 l9(i)=norm(s9(i,:)-ON(i,:));end