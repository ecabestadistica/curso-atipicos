function [idx,dm,mm,Ss,wval0,ndir] = kur_main(xs)

%
% [idx,dm,mean,Cov,vkur,ndir] = kur_main(x)
%
% Outlier identification based on the study of univariate
% projections onto the directions maximizing and minimizing
% the kurtosis coefficient, and directions obtained from a
% subsampling procedure assigning weights to the observations
%
% Inputs:   observations, x, (a matrix having a row for each observation)
% Outputs:  idx,  zero/one vector with ones in the positions of the
%                 suspected outliers
%           dm,   robust Mahalanobis distances
%           mean, robust mean estimator
%           Ss,   robust covariance matrix estimator
%           vkur, kurtosis coefficient values
%           ndir, number of directions used
%

% Daniel Pena / Francisco J Prieto 21/9/04

ep5 = sqrt(eps);
[n0,p] = size(xs);
nmxpass = Inf;         % max number of passes through basic outlier identification
%nmxpass = 1;         % max number of passes through basic outlier identification

stnd = 1;

% Initialization of parameters

%% ji2 percentiles (0.01)

ji2a = [ 6.64 9.21 11.35 13.28 15.09 16.81 18.48 20.09 21.67 23.21 ...
         24.73 26.22 27.69 29.14 30.58 32.00 33.41 34.81 36.20 37.57 ];

%% Numbers of directions obtained using different methods

dkmax = 2;     % Generate minimization and maximization directions (do not change lightly)
dkmxk = 1;     % Directions maximizing kurtosis
dkmnk = 1;     % Directions minimizing kurtosis
dksmp = 0;


ndk = [ dkmxk ; dkmnk ; dksmp ];
ndr = sum(ndk);

%% Cutoff values

ctf = 3.05 + 0.081*p;
vctf = ctf*ones(1,ndr);

%% minimum numbers of observations that are acceptable as good observations

lmn1 = max(floor(0.5*(n0 + p + 1)),2*p);
lmn2 = min(2*p,max(p + 2,floor(0.25*n0)));

%% standardize data (not done in principle)

if stnd,
  mm = mean(xs);
  S = cov(xs);
  xn = xs - ones(n0,1)*mm;
  Rr = chol(S);
  xn = ((Rr')\(xn'))';
else
  xn = xs;
end

xn0 = [xn (1:n0)'];
x = xn0;

%% Initialize parameters

n = n0;
flg = 1;
wval0 = [];
ndir = 0;
pass = 1;

while (n > lmn1)&(pass <= nmxpass)&(flg == 1),

  en = ones(n,1);
  
  Vv = kur_nwm(x(:,1:p),ndk);

  ndir = ndir + ndr;

  pr = x(:,1:p)*Vv;
  md = median(pr);
  prn = abs(pr - en*md);
  mad = median(prn);
  tt = prn./(en*mad);

  tctf = en*vctf;
  taux = tt./tctf;
  t = max(taux')';
  
%%% Exit if no observations were labelled as outliers

  in = find(t > 1);
  nn = length(in);
    
  if nn == 0,
    flg = 0;
    break
  end

%%% Exit if too many observations were labelled as outliers

  inn = find(t <= 1);
  nu = length(inn);
  if nu <= lmn2,
    [v,ix] = sort(t);
    ixx = ix(1:lmn2);
    x = x(ixx,:);
    [n,pp] = size(x);
    flg = 0;
    break
  end

%%% Extract remaining observations left to be analyzed and redo

  x = x(inn,:);
  [n,pp] = size(x);

  pass = pass + 1;

end

%% Extracting the indices of the outliers

idx = ones(n0,1);
[nn,pp] = size(x);
idx(x(:,pp)) = zeros(nn,1);

% recheck observations and relabel them

%% Cutoffs for Mahalanobis distances

if p <= 20,
  ctf = ji2a(p);
else
  ctf = (2.33 + sqrt(2*p-1))^2/2;
end

%% Mahalanobis distances using center and scale estimators
%% based on good observations

sidx = sum(idx);
s1 = find(idx);
s2 = find(idx == 0);
if sidx > 0,
  xx1 = xn0(s1,:);
  xx1r = xn(s1,:);
end
xx2r = xn(s2,:);

mm = mean(xx2r);
Ss = cov(xx2r);
if sidx > 0,
  aux1 = xx1r - ones(sidx,1)*mm;
  dd = Ss\aux1';
  dms = sum((aux1.*dd')');
else
  dms = [];
end

%% Ensure that at least lmn1 observations are considered good

ado = sidx + lmn1 - n0;
if ado > 0,
  [dmss,idms] = sort(dms);
  idm1 = idms(1:ado);
  s3 = s1(idm1);
  idx(s3) = zeros(ado,1);

  sidx = sum(idx);
  s1 = find(idx);
  s2 = find(idx == 0);
  if sidx > 0,
    xx1 = xn0(s1,:);
    xx1r = xn(s1,:);
  end
  xx2r = xn(s2,:);

  mm = mean(xx2r);
  Ss = cov(xx2r);
  if sidx > 0,
    aux1 = xx1r - ones(sidx,1)*mm;
    dd = Ss\aux1';
    dms = sum((aux1.*dd')');
  end
end

%% Check remaining observations and relabel if appropriate

while sidx > 0,

  s1 = find(dms <= ctf);
  s2 = length(s1);
  if s2 == 0,
    break
  end
  s3 = xx1(s1,pp);
  idx(s3) = zeros(s2,1);
  sidx = sum(idx);
  s1 = find(idx);
  s2 = find(idx == 0);
  if sidx > 0,
    xx1 = xn0(s1,:);
    xx1r = xn(s1,:);
  end
  xx2r = xn(s2,:);

  mm = mean(xx2r);
  Ss = cov(xx2r);
  if sidx > 0,
    aux1 = xx1r - ones(sidx,1)*mm;
    dd = Ss\aux1';
    dms = sum((aux1.*dd')');
  end
end

% Values to be returned

s2 = find(idx == 0);
mm = mean(xs(s2,:));
Ss = cov(xs(s2,:));

aux1 = xs - ones(n0,1)*mm;
dd = Ss\aux1';
dms = sum((aux1.*dd')');

dm = sqrt(dms);
