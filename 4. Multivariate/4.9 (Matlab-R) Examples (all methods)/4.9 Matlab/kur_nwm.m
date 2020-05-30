function Vv = kur_nwm(x0,ndk)

%
%    V = kur_nwm(x,ndir)
%
% Computation of directions that maximize and minimize
% the kurtosis coefficient of the projections
% and other directions based on ordering the observations
% The values of the projections are also computed
% To be used as a subroutine of kur_mod
%
% Inputs:  x, observations (by rows)
%          ndir,  [ num_dir_max_kur num_dir_min_kur num_dir_sd ]
% Outputs: V, directions maximizing/minimizing kurtosis coef.
%             maximization directions first
%

% Daniel Pena/Francisco J Prieto 23/5/00

% Initialization of parameters

[n,p0] = size(x0);

dkmax = 2;     % Generate minimization and maximization directions (do not change lightly)
if nargin < 2,
  dkmxk = p0;     % Directions maximizing kurtosis
  dkmnk = p0;     % Directions maximizing kurtosis
  dksmp = 0;    % Directions obtained by sampling
  ndk = [ dkmxk ; dkmnk ; dksmp ];
end

smpmode = 1;     % 1 = SD improved, 2 = SD original

%% Initialization of vectors

Vv = [];

%% Standardize data

mm = mean(x0);
S = cov(x0);
x = x0 - ones(n,1)*mm;
Rr = chol(S);
x = ((Rr')\(x'))';

% Computing directions

%% Choice of minimization/maximization/others

dk = 1;

%% Main loop to compute the desired number of directions

while (dk <= dkmax),

  xx = x;
  p = p0;
  pmx = min(ndk(dk),p-1);
  M = eye(p0);

  for i = 1:pmx,

    if dk == 1,
      a = max_kur(xx);
    elseif dk == 2,
      a = min_kur(xx);
    end

    la = length(a);
    za = zeros(la,1);
    za(1) = 1;
    w = a - za;
    nw = w'*a;
    if abs(nw) > eps,
      Q = eye(la) - w*w'/nw;
    else
      Q = eye(la);
    end

%% Compute projected values

    Vv = [ Vv (M*a) ];

    Qp = Q(:,2:p);
    M = M*Qp;

%% Reduce dimension

    Tt = xx*Q;
    xx = Tt(:,(2:p));

    p = p - 1;

  end

%% Compute last projection (if needed)

  if ndk(dk) > (p0 - 1),
    Vv = [ Vv M ];
  end

%% Proceed to other classes of directions

  dk = dk + 1;

end

% Obtain subsampling directions

if ndk(3) > 0,
  if smpmode == 1,
    V = sdw_dir(x,ndk(3));
  elseif smpmode == 2,
    [taux,V] = dir_sd(x,ndk(3));
  end
  Vv = [ Vv V ];
end

% Undo standardization transformation

Vv = Rr\Vv;
uaux = sum(Vv.*Vv);
Vv = Vv*diag(1../sqrt(uaux));
