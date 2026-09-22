 m=50;
L=wsNet(50,2,0.1);
deta=zeros(50,1);
for i=1:50
    R = normrnd(0.01, 0.005, 1, 1);
    A(i,6)=vpa(A(i,6),2); 
    if A(i,5)>=20&&A(i,5)<=45
    for j=1:50
         deta(i)=A(j,6)*R*L(i,j)+deta(i);
    end
    A(i,6)=A(i,6)+deta(i);
    A(i,6)=vpa(A(i,6),2);
    if (A(i,6)-fix(A(i,6))>0.50)
        A(i,6)=round(A(i,6));
    end
    end
end