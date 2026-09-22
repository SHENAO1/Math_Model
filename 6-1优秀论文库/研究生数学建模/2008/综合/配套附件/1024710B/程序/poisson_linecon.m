function [xps fps phaseps]=poisson_linecon(paraz,l)
xps=[];fps=[];phaseps=[];
for i=1:5
[temp1 temp2 x fval phase]=linecon(paraz,l);
xps=[xps;x];
fps=[fps;fval];
phaseps=[phaseps;phase];

Tw=(1-x([1,3],:)).*[x(5,:);x(5,:)];
lambda=(paraz(:,[1,2]))'.*Tw/3600;
Q1=[poissrnd(lambda(1,1)),poissrnd(lambda(1,2)),poissrnd(lambda(1,3))];
while max(max(Q1))>=18|min(min(Q1))<=8
    Q1=[poissrnd(lambda(1,1)),poissrnd(lambda(1,2)),poissrnd(lambda(1,3))];
end
Q2=[poissrnd(lambda(2,1)),poissrnd(lambda(2,2)),poissrnd(lambda(2,3))];
while max(max(Q2))>=18|min(min(Q2))<=8
    Q2=[poissrnd(lambda(2,1)),poissrnd(lambda(2,2)),poissrnd(lambda(2,3))];
end
Q=[Q1;Q2];
paraz=[(Q./Tw*3600)' [8000 4000;8000 4000;8000 4000]];
end