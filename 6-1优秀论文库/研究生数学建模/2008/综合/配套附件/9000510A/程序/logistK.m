function [beta,post,lli] = logistK(x,y,w,beta)

error(nargchk(2,4,nargin));

debug = 0;
if debug>0,
  h=figure(1);
  set(h,'DoubleBuffer','on');
end

[d,nx] = size(x);
[k,ny] = size(y);

if k < 2,
  error('Input y must encode at least 2 classes.');
end
if nx ~= ny,
  error('Inputs x,y not the same length.'); 
end

n = nx;

sumy = sum(y,1);
if abs(1-sumy) > eps,
  sumy = sum(y,1);
  for i = 1:k, y(i,:) = y(i,:) ./ sumy; end
end
clear sumy;

if nargin < 3, 
  w = ones(1,n);
end

w = w / max(w);

if nargin < 4,
  beta = 1e-3*rand(d,k);
  beta(:,k) = 0;	% fix beta for class k at zero
else
  if sum(beta(:,k)) ~= 0,
    error('beta(:,k) ~= 0');
  end
end

stepsize = 1;
minstepsize = 1e-2;

post = computePost(beta,x);
lli = computeLogLik(post,y,w);

for iter = 1:100,

  vis(x,y,beta,lli,d,k,iter,debug);


  [g,h] = derivs(post,x,y,w);


  if rcond(h) < eps, 

    for i = -16:16,
      h2 = h .* ((1 + 10^i)*eye(size(h)) + (1-eye(size(h))));
      if rcond(h2) > eps, break, end
    end
    if rcond(h2) < eps,
      warning(['Stopped at iteration ' num2str(iter) ...
               ' because Hessian can''t be conditioned']);
      break 
    end
    h = h2;
  end


  lli_prev = lli;


  while stepsize >= minstepsize,

    step = stepsize * (h \ g);
    beta2 = beta;
    beta2(:,1:k-1) = beta2(:,1:k-1) - reshape(step,d,k-1);


    post2 = computePost(beta2,x);
    lli2 = computeLogLik(post2,y,w);

    if lli2 > lli, 
      post = post2; lli = lli2; beta = beta2;
      break
    end

    stepsize = 0.5 * stepsize;
  end

  if 1-exp(lli/n) < 1e-2, break, end

  dlli = (lli_prev-lli) / lli;
  if abs(dlli) < 1e-3, break, end

  if stepsize < minstepsize, brea, end

  if lli < lli_prev,
    warning(['Stopped at iteration ' num2str(iter) ...
             ' because the log likelihood decreased from ' ...
             num2str(lli_prev) ' to ' num2str(lli) '.' ...
            ' This may be a bug.']);
    break
  end
end

if debug>0, 
  vis(x,y,beta,lli,d,k,iter,2); 
end

function post = computePost(beta,x)
  [d,n] = size(x);
  [d,k] = size(beta);
  post = zeros(k,n);
  bx = zeros(k,n);
  for j = 1:k, 
    bx(j,:) = beta(:,j)'*x; 
  end
  for j = 1:k, 
    post(j,:) = 1 ./ sum(exp(bx - repmat(bx(j,:),k,1)),1);
  end
  

function lli = computeLogLik(post,y,w)
  [k,n] = size(post);
  lli = 0;
  for j = 1:k,
    lli = lli + sum(w.*y(j,:).*log(post(j,:)+eps));
  end
  if isnan(lli), 
    error('lli is nan'); 
  end

function [g,h] = derivs(post,x,y,w)

  [k,n] = size(post);
  [d,n] = size(x);


  g = zeros(d,k-1);
  for j = 1:k-1,
    wyp = w .* (y(j,:) - post(j,:));
    for ii = 1:d, 
      g(ii,j) = x(ii,:) * wyp'; 
    end
  end
  g = reshape(g,d*(k-1),1);

  h = zeros(d*(k-1),d*(k-1)); 
  for i = 1:k-1,	% diagonal
    wt = w .* post(i,:) .* (1 - post(i,:));
    hii = zeros(d,d);
    for a = 1:d,
      wxa = wt .* x(a,:);
      for b = a:d,
        hii_ab = wxa * x(b,:)';
        hii(a,b) = hii_ab;
        hii(b,a) = hii_ab;
      end
    end
    h( (i-1)*d+1 : i*d , (i-1)*d+1 : i*d ) = -hii;
  end
  for i = 1:k-1,	% off-diagonal
    for j = i+1:k-1,
      wt = w .* post(j,:) .* post(i,:);
      hij = zeros(d,d);
      for a = 1:d,
        wxa = wt .* x(a,:);
        for b = a:d,
          hij_ab = wxa * x(b,:)';
          hij(a,b) = hij_ab;
          hij(b,a) = hij_ab;
        end
      end
      h( (i-1)*d+1 : i*d , (j-1)*d+1 : j*d ) = hij;
      h( (j-1)*d+1 : j*d , (i-1)*d+1 : i*d ) = hij;
    end
  end

function vis (x,y,beta,lli,d,k,iter,debug)

  if debug<=0, return, end

  disp(['iter=' num2str(iter) ' lli=' num2str(lli)]);
  if debug<=1, return, end

  if d~=3 | k>10, return, end

  figure(1);
  res = 100;
  r = abs(max(max(x)));
  dom = linspace(-r,r,res);
  [px,py] = meshgrid(dom,dom);
  xx = px(:); yy = py(:);
  points = [xx' ; yy' ; ones(1,res*res)];
  func = zeros(k,res*res);
  for j = 1:k,
    func(j,:) = exp(beta(:,j)'*points);
  end
  [mval,ind] = max(func,[],1);
  hold off; 
  im = reshape(ind,res,res);
  imagesc(xx,yy,im);
  hold on;
  syms = {'w.' 'wx' 'w+' 'wo' 'w*' 'ws' 'wd' 'wv' 'w^' 'w<'};
  for j = 1:k,
    [mval,ind] = max(y,[],1);
    ind = find(ind==j);
    plot(x(1,ind),x(2,ind),syms{j});
  end
  pause(0.1);

