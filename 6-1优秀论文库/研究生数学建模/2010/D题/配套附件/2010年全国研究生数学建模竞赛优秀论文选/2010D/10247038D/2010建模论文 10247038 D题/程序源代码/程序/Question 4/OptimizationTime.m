clear;
clc;

% 几何尺寸
X=0:1:600;
k = 1;
for i =1:601
    f2(i) = Diff2Function(X(i));
    if f2(i)>0
        p(k) = (1+DiffFunction(X(i)^2))^1.5 / abs(f2(i));
        k = k + 1;
    end
end
p = min(p);
r = p;
arf = 2*asin(10/r);


% 遍历求解
Start = 0.1;
Step = 0.01;

i = 1;
Min = 1000;
MinIndex = 0;
while Start<4
    Error = Optimization(Start,arf,r);
    Result(i,1) = Start;
    Result(i,2) = Error;
    
    if Error<Min 
        Min = Error;
        MinIndex = i;
    end
    
    i = i + 1;
    Start = Start + Step;
end
Step = Result(MinIndex,1);

% 计算最小计算时间
[Error,OrderList] = Optimization(Step,arf,r);
TOrderList(:,1) = OrderList(:,1)/60;
TOrderList(:,2) = OrderList(:,2)/100;
TOrderList(:,3) = OrderList(:,3)/100;
[n,m] = size(TOrderList);
for i =1:n
    Time(i) = max(abs(TOrderList(i,:)));
end
Time = Time';
TotalTime = sum(Time)/60;