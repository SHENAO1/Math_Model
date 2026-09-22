clear;
load dot_stop.mat;
T = -[23.4 52.3 23.6 32.6 33.6 43.4 52.3 43.4 52.3 25.6 32.6 43.6 65.3 52.3...
    25.6 32.6 43.6 23.4 52.3...
    23.6 32.6 33.6 43.4 52.3 46.8 25.6 32.6 43.6 52.3 25.6 32.6 43.6...
    23.6 32.6 33.6 43.4 52.3 25.6 32.6 43.6 52.3 65.3 52.3 25.6 32.6 43.6];
m = 46;R = 6371.004;a1 = 0.076;a2 = 0.842;a3 = -0.100;%3¸öa
for i = 0:45
   for  j = 0:5
       k = i-2^j+1;
       if ((k-1)/2.^j>=0)&&(k/2.^j<=1)
           jk(i+1,1) = j;
           jk(i+1,2) = k;
       end;
   end;
end;
jk = jk';
jk = jk(jk>0)';
jk = [0,0,0,jk];
jk = reshape(jk,2,46);
n_ = linspace(0,1,47);
n = n_(1:46);
for i = 1:46;
    H_( (n>=0&n<(jk(2,i)-1)/2.^jk(1,i)) | ( n>=jk(2,i)/2.^jk(1,i)&n<=1 ) ) = 0;
    H_( (n>=(jk(2,i)-1)/2.^jk(1,i) & n<(jk(2,i)-1/2)/2.^jk(1,i)) ) = 2.^(jk(1,i)/2);
    H_( (n>=(jk(2,i)-1/2)/2.^jr(1,i) & n<jk(2,i)/2.^jk(1,i)) ) = -2.^(jk(1,i)/2);
    H(i,:) = H_;
end
H(1,:) = 1/m^(1/2);

Qb = 1/m*(triu(ones(m,m),0)- diag( 1/2*ones(1,m) )); 
Qh = H.*Qb.*(H');
dot_stop(1,:) = dot_stop(1,:)/90;        %
dot_stop(2,:) = (dot_stop(2,:)+180)/360;
for i = 1:46;
    for j = 1:46;
    Z(i,j) =(a1 + a2...
        *exp(a3*R*acos(sin(dot_stop(2,j))*sin(dot_stop(2,i))*...
        cos(dot_stop(1,j) - dot_stop(1,i)) + cos(dot_stop(2,j))*cos(dot_stop(2,i)) )));   % sin(pi*dot_stop(2,j)/2)*
    end;
end;
C =  H.*Z.*H^(-1);
p = H'*Qh*C*Qh*H; 
p = [p;1];
P = T'*T;  P = [P,(-ones(46,1))]; P = [P;ones(1,47)]; P(47,47) = 0;
w = p*P^-1;



       

