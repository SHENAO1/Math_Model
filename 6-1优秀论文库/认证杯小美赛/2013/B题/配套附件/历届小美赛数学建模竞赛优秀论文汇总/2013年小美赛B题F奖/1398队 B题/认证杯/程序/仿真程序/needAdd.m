function A=needAdd(A,m)

for j=1:50
		for i=1:49
            if (A(i,3)<=A(i+1,3))
				p=A(i,:);
				A(i,:)=A(i+1,:);
				A(i+1,:)=p;
            end
        end
   end

preNeed=A(1,:);
preNeed(1)=0;
preNeed(2)=1;
preNeed(3)=m;
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
      
 for j=1:50
		for i=1:49
            if (A(i,1)>=A(i+1,1))
				p=A(i,:);
				A(i,:)=A(i+1,:);
				A(i+1,:)=p;
            end
        end
   end

 