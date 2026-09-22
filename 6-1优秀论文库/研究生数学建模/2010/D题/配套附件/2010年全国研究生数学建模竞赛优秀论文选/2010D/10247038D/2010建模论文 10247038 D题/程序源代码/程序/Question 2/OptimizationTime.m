clear
clc

Start = 0.1;
Step = 0.01;

% 遍历求解
i = 1;
Min = 10;
MinIndex = 0;
while Start<4
    Error = Optimization(Start);
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
[Error,OrderList] = Optimization(Result(MinIndex,1));
TOrderList(:,1) = OrderList(:,1)/60;
TOrderList(:,2) = OrderList(:,2)/100;
TOrderList(:,3) = OrderList(:,3)/100;
[n,m] = size(TOrderList);
for i =1:n
    Time(i) = max(abs(TOrderList(i,:)));
end
Time = Time';
TotalTime = sum(Time)/60;