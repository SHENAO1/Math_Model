function [pop] = initial(s,popSize)
solSize=size(s,2);
pop=zeros(popSize,solSize);
for n=1:popSize
    pop(n,:)=randArray(s);
    pop(n,:)=s;
end
tm=zeros(popSize,1);
pop=[pop tm];

for n=1:popSize   
    [pop(n,:) pop(n,solSize+1)]=routFitness(pop(n,:),0);
end
