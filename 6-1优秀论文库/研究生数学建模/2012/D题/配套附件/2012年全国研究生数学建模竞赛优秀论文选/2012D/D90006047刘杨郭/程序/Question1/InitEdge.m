
function [PP,nP]=InitEdge(BP,n)

% BP(n+1,:)=BP(1,:);
k=1;PP=[];nP=0;
for i=1:n-1
    sP.x=BP(i,1);sP.y=BP(i,2);
    eP.x=BP(i+1,1);eP.y=BP(i+1,2);
    [P,Num]=BresenLine(sP,eP);
    PP(k:k+Num-2,:)=P(1:Num-1,:);
    k=k+Num-1;
end
nP=k-1;

return

