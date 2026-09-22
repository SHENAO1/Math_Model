textdata=Sheet2;
data=Sheet1;
Fuzai=60;
Zengliang=[-1,-1,-1,1,-4,4,2,5,2,-8,-5,5,2,-6,-3,2];
Tage=1;
S=data(16:27,:);

S1(16,1)=0;
for i=15:-1:11
    S1(i,1)=S(i-3,1);
end
S1(10,1)=0;
S1(9,1)=0;
S1(8,1)=0;
S1(7,1)=0;
for i=6:-1:1
    S1(i,1)=S(i,1);
end
SIJ=dianju;
Sij=SIJ(2:17,2:17);
for i=1:16
    for j=1:16
        p0=(Fuzai+Zengliang(1,i))/65*S1(i,1);
        q0=(Fuzai+Zengliang(1,j))/65*S1(j,1);
        pq=(Fuzai+Zengliang(1,i)+Zengliang(1,j))/65*Sij(i,j);
       S_biaoji(i,j)=p0+q0-pq;
    end
end
for i=1:16
    for j=1:16
        if S_biaoji(i,j)==Inf
           S_biaoji(i,j)=NaN;
        end
    end
end
for i=1:16
    for j=1:16
        if i==j
            S_biaoji(i,j)=NaN;
        end
    end
end
T=zeros(16,16);
T(7,8)=1;
T(8,7)=1;
T(8,9)=1;
T(9,8)=1;
distance=0;
for H=1:100
    large1=max(S_biaoji);
    [large,n]=max(large1);
    [large,m]=max(S_biaoji(:,n));
    if large==-11
        break;
    else
        if (sum(T(m,:))<=1)&&(sum(T(:,n))<=1)
            distance=distance+Sij(m,n)+S1(m,1)+S1(n,1);
            Tage=Tage+1;
            if (distance/30+5/60*Tage)<=6
                if(sum(T(m,:))==0)&&(sum(T(:,n))==0)
                    Fuzai=Fuzai+Zengliang(1,m)+Zengliang(1,n);
                else
                    if sum(T(m,:))==0
                    Fuzai=Fuzai+Zengliang(1,m);
                    elseif sum(T(:,n))==0
                        Fuzai=Fuzai+Zengliang(1,n);
                    end
                end
                if Fuzai>65
                    continue;
                else
                    T(m,n)=1;
                    T(n,m)=1;
                    Tage=Tage+1;
                end
               if (m==5&&n==2)||(m==2&&n==5)
                T(m,n)=0;
                T(n,m)=T(m,n);
                end
                if (m==15&&n==11)||(m==11&&n==15)
                T(m,n)=0;
                T(n,m)=T(m,n);
                end
            else
                distance=0;
                Tage=1;
                Fuzai=60;
                S_biaoji(m,n)=NaN;
                continue;
            end
        else
            S_biaoji(m,n)=NaN;
            continue;
        end
        S_biaoji(m,n)=NaN;
    end
end

                
                
    
        
        

