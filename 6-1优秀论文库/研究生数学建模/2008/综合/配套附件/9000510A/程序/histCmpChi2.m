function d = histCmpChi2(h1, h2)


[N B] = size(h1);
d = zeros(N,N);
for i=1:N
  h1i = repmat(h1(i,:), N, 1);
  numer = (h1i - h2).^2;
  denom = h1i + h2 + eps; % if denom=0, then numer=0
  d(i,:) = sum(numer ./ denom, 2);
end
  
