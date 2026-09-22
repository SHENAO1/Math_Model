b=0;
for i=1:10000
    r=binornd(1,0.2,1,20);
    a=sum(r);
    if a>=2
        b=b+1;
    end
end
c=b/10000