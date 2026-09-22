syms a b;
   c=[a b]';
    A=[318 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 315 0 0 0 0 0 0 0 0 0 0 0 264 32 0 0 0 57 0 70];
   B=cumsum(A);
   n=length(A);
for i=1:(n-1)
   C(i)=(B(i)+B(i+1))/2;
end
   D=A;D(1)=[];
   D=D';
   E=[-C;ones(1,n-1)];
   c=inv(E*E')*E*D;
   c=c';
   a=c(1);b=c(2);
   F=[];F(1)=A(1);
for i=2:(n+11)
   F(i)=(A(1)-b/a)/exp(a*(i-1))+b/a;
end
   G=[];G(1)=A(1);
for i=2:(n+11)
   G(i)=F(i)-F(i-1);
end
  t1=1976:2014;
  t2=1976:2025;
  t3=1977:2025;
  y=diff(G);
  plot(t1,A,'o',t2,G)
  xlabel( 'years' )
  ylabel( 'cases of infection ' )
  grid on