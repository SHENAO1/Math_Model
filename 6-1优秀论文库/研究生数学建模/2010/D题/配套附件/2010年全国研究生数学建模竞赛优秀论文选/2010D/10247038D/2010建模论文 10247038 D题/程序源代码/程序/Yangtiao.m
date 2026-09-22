%ÑùÌõ²åÖµ
[m,n] = size(OrderList);
InterOrder =zeros(m,n+1);
for i=1:m
    for j =1:i
        InterOrder(i,1:3) = InterOrder(i,1:3) + abs(OrderList(j,:));
        InterOrder(i,4) = InterOrder(i,4) + Time(j);
    end
end
It=InterOrder(:,4);
I1=InterOrder(:,1);
I2=InterOrder(:,2);
I3=InterOrder(:,3);