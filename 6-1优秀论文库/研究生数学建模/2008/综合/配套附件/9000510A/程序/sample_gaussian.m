function M = sample_gaussian(mu, Sigma, N)

if nargin==2
  N = 1;
end

mu = mu(:);
n=length(mu);
[U,D,V] = svd(Sigma);
M = randn(n,N);
M = (U*sqrt(D))*M + mu*ones(1,N); % transform each column
M = M';

