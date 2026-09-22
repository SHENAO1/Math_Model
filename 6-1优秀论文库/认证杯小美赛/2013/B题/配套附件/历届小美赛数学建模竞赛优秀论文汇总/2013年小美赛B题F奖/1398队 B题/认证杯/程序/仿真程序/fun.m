function A=fun(A1,i)    
        A=A1;        
        preNeed=A(i,:);
        A(i,2)=0;
        A(i,3)=0;
        A(i,6)=0;
        preNeed(1)=0;
        
        while(1)
            for i=1:50
                if (A(i,6)>=preNeed(3)&&A(i,3)<preNeed(3))
                    nextNeed=A(i,:);
                   	A(i,2)=preNeed(2);
                    A(i,3)=preNeed(3);             
                    preNeed=nextNeed;
                    break;
                end
            end
            if i==50
            break;
            end
        end