n1=[10 20 20 20 20];
n2=[1 2 2 2 2];
jibie=[5 4,1 4,4 5,3 3,3]
R=100;
T=1000;
We=20000;
RC=n1*R;
TC=n2*T;
KC=n2*We;
FC=[7500 7500 12000 12000 9000];
C=RC+TC+KC+FC
plot(C,'r.-','markersize',30)
xlabel('year')
ylabel('cost /гд')