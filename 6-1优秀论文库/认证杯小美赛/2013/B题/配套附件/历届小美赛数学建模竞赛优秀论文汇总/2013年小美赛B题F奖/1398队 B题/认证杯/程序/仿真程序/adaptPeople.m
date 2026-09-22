m=50;n=6;
A=randint(m,n,0);

for i=1:50
    A(i,1)=i;
        A(i,2)=1;
    %A(i,3)=randint(1,1,[1,5]);          %代表工作级别
    while (1)
        A(i,3) = normrnd(1,3, 1, 1);
        if (A(i,3)>=1&&A(i,3)<6)
        break;
        end
    end
    A(i,3)=fix(A(i,3));
    
    if (A(i,2)==0)
		A(i,3)=0;
    end
    	A(i,4)=randint(1,1,[0,1]);
    if (A(i,4)==0)
        while (1) 
        A(i,5) = normrnd(45,30, 1, 1);
        if (17<A(i,5)&&A(i,5)<60)
            break;
        end
        end
    else
        while 1
        A(i,5) = normrnd(40,30, 1, 1);
        if (17<A(i,5)&&A(i,5)<55)
            break;
        end
        end
    end
    A(i,5)=fix(A(i,5));
    while (1)
        A(i,6) = normrnd(1,3, 1, 1);
        if (A(i,6)>=1&&A(i,6)<6)
        break;
        end
    end
    A(i,6)=fix(A(i,6));
    if (A(i,6)<A(i,3))
        A(i,6)=A(i,3);
    end
end





