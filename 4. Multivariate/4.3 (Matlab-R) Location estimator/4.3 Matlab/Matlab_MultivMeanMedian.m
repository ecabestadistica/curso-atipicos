% Simulate data with outliers
cleandata=[randn(80,1) randn(80,1)]; %Vector 80x1 of pseudorandom values drawn from the standard normal distribution
plot(cleandata(:,1),cleandata(:,2),'o','LineWidth',2,'MarkerSize',15)
xlabel('X1','FontSize', 30)
ylabel('X2','FontSize', 30)
title('Simulated data with outliers','FontSize', 30)
hold on
mc=mean(cleandata);
plot(mc(1),mc(2),'*y','LineWidth',2,'MarkerSize',15) %Plot the mean vector of clean data
out=[20+0.5*randn(20,1) 20+0.5*randn(20,1)]; %cluster of 20 outliers from N(20,0.5^2)
plot(out(:,1),out(:,2),'*r','LineWidth',2,'MarkerSize',15)
data=[cleandata;out]; % Clean data + Outliers

% Calculate the mean vector of data with outliers
md=mean(data);
plot(md(1),md(2),'*m','LineWidth',2,'MarkerSize',15)

% Calculate the median vector of data with outliers
med=median(data);
plot(med(1),med(2),'*g','LineWidth',2,'MarkerSize',15)
lgd=legend('clean data','outliers','mean of clean data','mean of all data','median of all data');
lgd.FontSize = 30;








