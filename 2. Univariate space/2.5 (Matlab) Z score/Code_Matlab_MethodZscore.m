%% Case1
data=[3.2, 3.4, 3.7, 3.7, 3.8, 3.9, 4, 4, 4.1, 4.2, 4.7, 4.8, 14, 15];
m=mean(data);
s=std(data); %In this case we are using the unbiased estimator of standard deviation
Zscore=(data-m*ones(1,length(data)))./s;
SD3=[-3,3];
% Function that detects the outliers with 3SD
outliers3SD=data((Zscore<SD3(1) | Zscore>SD3(2))); % empty

%% Case2
data=[3.2, 3.4, 3.7, 3.7, 3.8, 3.9, 4, 4, 4.1, 4.2, 4.7, 4.8, 14];
m=mean(data);
s=std(data); %In this case we are using the unbiased estimator of standard deviation
Zscore=(data-m*ones(1,length(data)))./s;
SD3=[-3,3];
% Function that detects the outliers with 3SD
outliers3SD=data((Zscore<SD3(1) | Zscore>SD3(2))); % value 14
