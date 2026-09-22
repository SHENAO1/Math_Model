function l=wsNet(N,K,p)
%disp('WS小世界网络模型')
%N=input('请输入网络节点数');
%K=input('请输入与节点左右相邻的K/2的节点数');
%p=input('请输入随机重连的概率');
angle=0:2*pi/N:2*pi-2*pi/N;
x=100*cos(angle);
y=100*sin(angle);
%scatter(x,y,'r');
%hold on;
%生成最近邻耦合网络；
l=zeros(N);
%disp(l);
for i=1:N
    if i+K<=N
       for j=i+1:i+K
           l(i,j)=1;
       end
    else 
        for j=i+1:N
            l(i,j)=1;
        end
        for j=1:((i+K)-N)
            l(i,j)=1;
        end
    end
    if K<i
        for j=i-K:i-1
          l(i,j)=1;
        end
    else 
        for j=1:i-1
             l(i,j)=1;
        end
        for j=N-K+i:N
            l(i,j)=1;
        end
    end
end
%disp(l);
%随机化重连
for i=1:N
    for j=i+1:N
      if  l(i,j)==1
        pp=unifrnd(0,1);
        if pp<=p
            l(i,j)=0;
            l(j,i)=0;
            b=unidrnd(N);
            while i==b
                b=unidrnd(N);
            end
            l(i,b)=1;
            l(b,i)=1;
        end
      end
    end
end 
%hold on;
%根据邻接矩阵连线
%for i=1:N
%     for j=1:N
%         if l(i,j)==1
%             %plot([x(i),x(j)],[y(i),y(j)],'linewidth',1);
%           line([x(i),x(j)],[y(i),y(j)]);
%         end
%            end
% end
% hold off


%aver_path=aver_pathlength(A);
%disp(aver_path);