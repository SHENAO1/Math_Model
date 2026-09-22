function [beta,p,lli] = logist2(y,x,w)


error(nargchk(2,3,nargin));

if size(y,2) ~= 1,
  error('Input y not a column vector.');
end
if size(y,1) ~= size(x,1), 
  error('Input x,y sizes mismatched.'); 
end

[N,k] = size(x);


if nargin < 3, 
  w = 1;
end

w = w / max(w);

beta = zeros(k,1);

iter = 0;
lli = 0;
while 1==1,
  iter = iter + 1;

  p = 1 ./ (1 + exp(-x*beta));	

  lli_prev = lli;
  lli = sum( w .* (y.*log(p+eps) + (1-y).*log(1-p+eps)) );

  wt = w .* p .* (1-p);		

  deriv = x'*(w.*(y-p));


  hess = zeros(k,k);
  for i = 1:k,
    wxi = wt .* x(:,i);
    for j = i:k,
      hij = wxi' * x(:,j);
      hess(i,j) = -hij;
      hess(j,i) = -hij;
    end
  end

  if (rcond(hess) < eps), 
    error(['Stopped at iteration ' num2str(iter) ...
           ' because Hessian is poorly conditioned.']);
    break; 
  end;

  step = hess\deriv;
  beta = beta - step;

  tol = 1e-6;
  if abs(deriv'*step/k) < tol, break; end;

end;

