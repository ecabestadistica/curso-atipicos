%% LOAD THE DATA
load("stars.mat")
X=stars;
[~,p]=size(X);
plot(X(:,1),X(:,2),'ob')
xlabel('Log(effective surface temperature)')
ylabel('Log(light intensity)')
title('Star dataset')
model=ltsregres(X(:,1),X(:,2),'classic',1)
model.slope
model.int
model.classic.slope
model.classic.int