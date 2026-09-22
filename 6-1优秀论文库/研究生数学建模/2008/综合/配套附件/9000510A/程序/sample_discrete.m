function M = sample_discrete(prob, r, c)

n = length(prob);

if nargin == 1
  r = 1; c = 1;
elseif nargin == 2
  c == r;
end

R = rand(r, c);
M = ones(r, c);
cumprob = cumsum(prob(:));

if n < r*c
  for i = 1:n-1
    M = M + (R > cumprob(i));
  end
else
  % loop over the smaller index - can be much faster if length(prob) >> r*c
  cumprob2 = cumprob(1:end-1);
  for i=1:r
    for j=1:c
      M(i,j) = sum(R(i,j) > cumprob2)+1;
    end
  end
end



