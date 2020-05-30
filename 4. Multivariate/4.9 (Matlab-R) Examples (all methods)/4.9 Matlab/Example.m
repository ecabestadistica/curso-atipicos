%% LOAD THE DATA
load("stars.mat")
X=stars;
[~,p]=size(X);
plot(X(:,1),X(:,2),'ob')

%% Classic Mahalanobis
cl = mahal(X,X) %square classic MD
outcl=find(cl>chi2inv(0.975,p));
figure
plot(X(:,1),X(:,2),'ob')
hold on
plot(X(outcl,1),X(outcl,2),'r*')
title('Classic MD')

%% Other method to obtain classic MD with LIBRA package
clobj = mcdcov(X,'classic',1,'plots',0) %square classic MD
outcl=find((clobj.classic.md).^2>chi2inv(0.975,p));
figure
plot(X(:,1),X(:,2),'ob')
hold on
plot(X(outcl,1),X(outcl,2),'r*')
title('Classic MD')
% See graphs from LIBRA
clobj = mcdcov(X,'classic',1,'plots',1)

%% Detected outliers by Method MCD (with classical quantile)
[rew,raw]=mcdcov(X,'classic',0,'plots',0)
dmcd=raw.rd
outmcd=find(dmcd.^2>chi2inv(0.975,p));
figure
plot(X(:,1),X(:,2),'ob')
hold on
plot(X(outmcd,1),X(outmcd,2),'r*')
title('MCD')
outmcd


%% Detected outliers by Method Adjusted MCD (adjusted quantile from Filzmoser)
[damcd,outamcd]=AdjustedMCD(X,dmcd');%%%%%
figure
plot(X(:,1),X(:,2),'ob')
hold on
plot(X(outmcd,1),X(outmcd,2),'r*')
title('Adjusted MCD')
outamcd

%% Detected outliers by Method Kurtosis (using Peña and Prieto method Kurtosis)
[outk]=KurtosisPP(X);
figure
plot(X(:,1),X(:,2),'ob')
hold on
plot(X(outk,1),X(outk,2),'r*')
title('Kurtosis')
outk

%% Detected outliers by Method OGK (using Matlab function robustcov)
[~,~,distogk,indexogk]=robustcov(X,'Method','ogk');
[outogk]=find(indexogk==1);
figure
plot(X(:,1),X(:,2),'ob')
hold on
plot(X(outogk,1),X(outogk,2),'r*')
title('OGK')
outogk


