load d.mat



for i=1:22;
    for j=1:22;
        b1=d(:,:,i);
        b2=d(:,:,j);
        [h,r1,k]=charactermatch(b1,b2);
       % H(:,:,4*(i-1)+j)=h;
        R(i,j)=r1;
        K(i,j)=k;
    end
end
%H
sqrt(R)
%K
        
