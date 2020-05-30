%Log brain and log body weight of 28 species
load("brainbodyweightdata.mat")

%Classical estimators
clmu=mean(bc);
clsigma=cov(bc);

% You have to add in the path the LIBRA package from https://wis.kuleuven.be/stat/robust/Programs/LIBRA/download-links
[rew,raw]=mcdcov(bc); %add 'plots',0 if you don't want the plots
%rew are the reweighted estimators, raw are the final estimators
mcdmu=raw.center;
mcdsigma=raw.cov;

dist=mahalanobis(bc,clmu,'cov',clsigma);
figure
ellipsplot(clmu,clsigma,bc,dist)
figure
robdist=mahalanobis(bc,mcdmu,'cov',mcdsigma);
ellipsplot(mcdmu,mcdsigma,bc,robdist)

%outliers
[n,~]=size(bc)
index=1:n
%raw.wt gives weight 1 to normal obs and weight 0 to outliers
index(~raw.wt)

