function [xps fps phaseps]=poisson_spacecon(paraz,l)
xps=[];fps=[];phaseps=[];
for i=1:5
[temp1 temp2 x fval phase]=spacecon(paraz,l);
xps=[xps;x];
fps=[fps;fval];
phaseps=[phaseps;phase];

Tw=(1-x([1,3],:)).*[x(5,:);x(5,:)];
lambda=(paraz(:,[1,2]))'.*Tw/3600;
Q1=[poissrnd(lambda(1,1)),poissrnd(lambda(1,2)),poissrnd(lambda(1,3))];
while max(max(Q1))>=18|min(min(Q1))<=8
    Q1=[poissrnd(lambda(1,1)),poissrnd(lambda(1,2)),poissrnd(lambda(1,3))];
end
Q2=[poissrnd(lambda(1,4)),poissrnd(lambda(1,5)),poissrnd(lambda(1,6))];
while max(max(Q2))>=18|min(min(Q2))<=8
    Q2=[poissrnd(lambda(1,4)),poissrnd(lambda(1,5)),poissrnd(lambda(1,6))];
end
Q3=[poissrnd(lambda(2,1)),poissrnd(lambda(2,2)),poissrnd(lambda(2,3))];
while max(max(Q3))>=18|min(min(Q3))<=8
    Q3=[poissrnd(lambda(2,1)),poissrnd(lambda(2,2)),poissrnd(lambda(2,3))];
end
Q4=[poissrnd(lambda(2,4)),poissrnd(lambda(2,5)),poissrnd(lambda(2,6))];
while max(max(Q4))>=18|min(min(Q4))<=8
    Q4=[poissrnd(lambda(2,4)),poissrnd(lambda(2,5)),poissrnd(lambda(2,6))];
end
Q=[Q1 Q2;Q3 Q4];
paraz=[(Q./Tw*3600)' [8000 4000;8000 4000;8000 4000;8000 4000;8000 4000;8000 4000]];
end