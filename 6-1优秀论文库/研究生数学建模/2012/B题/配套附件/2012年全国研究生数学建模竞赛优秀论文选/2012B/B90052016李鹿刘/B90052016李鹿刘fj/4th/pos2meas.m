function [comalfa,combeta]=pos2meas(compos,comxs,comy9)%%%%%%%%%%%由解算后的坐标反推量测
%%%%compos :目标坐标；comxs:目标在观测坐标系下的坐标；comy9:卫星运动状态；
y9=comy9(1:2:5,:);
tempalfa=[]
tempbeta=[];
for i=1:length(comy9)
x09=y9(1,i);%%%%%%%%%对应于t时刻的坐标
y09=y9(2,i);
z09=y9(3,i);
r09=norm(y9(:,i));
thou09=norm(y9(1:2,i));
A=[x09/r09 -y09/thou09 -x09*z09/r09/thou09; y09/r09 x09/thou09 -y09*z09/r09/thou09;z09/r09 0 thou09/r09];
%tempvector=1/comxs(i)*inv(A'*A)*A'*(compos(:,i)-y9(:,i));
S=cat(2,-(compos(:,i)-y9(:,i))/comxs(i),A);
[u,v,w]=svd(S);
tempvector=w(2:end,end)/w(1,end);
tempalfa=[tempalfa tempvector(2)];
tempbeta=[tempbeta tempvector(3)];
end
comalfa=tempalfa;
combeta=tempbeta;