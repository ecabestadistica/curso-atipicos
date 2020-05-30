function V = sdw_dir(x,nr,lbl)

%
% Estimador de Stahel-Donoho modificado.
% Submuestreo, nr replicaciones
% Se muestrean pares de observaciones y se asignan pesos
% a distintos grupos en las proyecciones
%
%    V = sdw_dir(x,num_dir,labels)
%
%  V,       direcciones generadas
%
%  num_dir, numero de direcciones a generar
%  labels,  preordering of the observations (if available)
%

nlbl = 0;
if nargin < 3,
  nlbl = 1;
end

%%%%%%%%%%%%

%% To ensure affine equivariance load state for generator (to reset)

%load state
%w = rand("state",st');

%%%%%%%%%%%%

[n,p] = size(x);

ep5 = sqrt(eps);
mdi = floor((n+1)/2);
k1 = p-1+floor((n+1)/2);
k2 = p-1+floor((n+2)/2);
fct = sqrt(2)*erfinv(k1/n);

%% Numero de grupos a considerar en las proyecciones para cada conjunto de pesos

s_grp = 2*p;
n_grp = floor(n/s_grp);

% Generacion de direcciones

ndir = 0;
V = [];

while 1,

%% Sampling to obtain initial projections and weights

  if nlbl,
    nn1 = min(1 + floor(rand*n),n);
    nn2 = nn1;
    while nn2 == nn1,
      nn2 = min(1 + floor(rand*n),n);
    end
    dd = x(nn1,1:p) - x(nn2,1:p);
    dd = dd'/norm(dd);

    pr = x*dd;
    [ww,lbl] = sort(pr);
  end

%% Direcciones de Stahel-Donoho  

  for j = 1:n_grp,
    [dummy,bb] = sort(rand(s_grp,1));
    nn = bb(1:p);
    idr = lbl((1+(j-1)*s_grp):(j*s_grp));
    y1 = x(idr(nn),:);
    [ll,uu] = lu(y1);
    aux = abs(diag(uu));
    piv = min(aux);
    piw = max(aux);
    if (piv/piw) > ep5,
      aux = ll\ones(p,1);
      dd = uu\aux;
      dd = dd/norm(dd);
      V = [ V dd ];
      ndir = ndir + 1;
      if ndir >= nr,
          return
      end
    end
  end
end
