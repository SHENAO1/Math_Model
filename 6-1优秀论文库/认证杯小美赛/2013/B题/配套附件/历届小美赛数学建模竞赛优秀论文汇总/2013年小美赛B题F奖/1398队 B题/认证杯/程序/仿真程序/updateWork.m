for i=1:50
   A(i,5)=A(i,5)+1;
end

for j=1:50
		for i=1:49
            if (A(i,3)<=A(i+1,3))
				p=A(i,:);
				A(i,:)=A(i+1,:);
				A(i+1,:)=p;
            end
        end
   end

for i=1:50
    if (A(i,5)>=60||(A(i,5)>=55&&A(i,4)==1))
        preNeed=A(i,:);
        A=fun(A,i);
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

    
