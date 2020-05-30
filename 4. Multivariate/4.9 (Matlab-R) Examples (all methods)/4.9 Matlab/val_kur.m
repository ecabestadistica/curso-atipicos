function mc = val_kur(x,d,km)

%
%     mc = val_kur(x,dir,k)
%
% Cluster identification from projections onto directions
% maximizing and minimizing the kurtosis coefficient of
% the data
%
% Evaluate the moment coefficient of order k
% for the univariate projection of multivariate data
% (to be used as a subroutine of clus_kur)
%
%
% Inputs:  x, observations (by rows)
%          dir, projection direction
%          k, order of the moment (k=4 by default)
% Output:  mc, value of the moment coefficient for the
%          univariate data
%

% DP/FJP 23/5/00

if nargin < 3,
  km = 4;
end

[n,p] = size(x);
[p1,p2] = size(d);
if p ~= p1,
  disp('Data dimensions are not correct');
  return
end

t = x*d;
tm = mean(t);
tt = abs(t - tm);
vr = sum(tt.^2)/(n-1);
kr = sum(tt.^km)/n;
mc = kr/vr^(km/2);
