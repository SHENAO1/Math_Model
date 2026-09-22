%用状态转移矩阵求任意时间下的位置、速度、加速度、加加速度;
fei=eee;
[m,n]=size(fei);
t=0.2;
X=[fei(1,1:3),result(1:3,1)',result(1:3,2)',result(1:3,3)'];
TR=[eye(3)     eye(3).*t     eye(3).*0.5.*(t).^2    eye(3)./6.*(t).^3;...
    zeros(3)   eye(3)        eye(3).*t              eye(3).*0.5.*(t).^2;...
    zeros(3)   zeros(3)      eye(3)                 eye(3).*t;...
    zeros(3)   zeros(3)      zeros(3)               eye(3)];
resultall=[];
resultall(1,1:12)=X;
X=X';
for i=1:m-1
    X=TR*X;
    resultall(i+1,1:12)=X';
end
    
