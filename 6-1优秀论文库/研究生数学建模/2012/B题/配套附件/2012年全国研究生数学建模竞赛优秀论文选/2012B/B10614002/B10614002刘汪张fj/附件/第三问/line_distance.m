function lnds=line_distance(a,b) %求两直线距离
n=length(a(:,1));
lnds=zeros(n,2);
lnds(:,1)=a(:,1);
for i=1:n
a1=a(i,2);
a2=b(i,2);
b1=a(i,3);
b2=b(i,3);
c1=a(i,4);
c2=b(i,4);
d1=a(i,5);
d2=b(i,5);
lnds(i,2)=abs(det([0,b2-b1,d2-d1;1,a1,c1;1,a2,c2]))./sqrt(det([1,a1;1,a2]).^2+det([a1,c1;a2,c2]).^2+det([c1,1;c2,1]).^2);
end
