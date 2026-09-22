function p = matrix_T_pdf(A, M, V, K, n)


[d m] = size(K);
is = 1:d;
c1 = prod(gamma((n+1-is)/2)) / prod(gamma((n-m+1-is)/2));
c2 = det(K)^(d/2) / det(pi*V)^(m/2); %% pi or 2pi?
p = c1 * c2 * det((A-M)'*inv(V)*(A-M)*K + eye(m))^(-n/2);

