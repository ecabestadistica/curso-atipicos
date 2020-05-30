%First example
data=[3.2, 3.4, 3.7, 3.7, 3.8, 3.9, 4, 4, 4.1, 4.2, 4.7, 4.8, 14, 15];
m=mean(data);
s=std(data); %In this case we are using the unbiased estimator of standard deviation
SD2=[m-2*s,m+2*s];
SD3=[m-3*s,m+3*s];
% Function that detects the outliers with 2SD or 3SD
outliers2SD=data((data<SD2(1) | data>SD2(2))); % 14 and 15
outliers3SD=data((data<SD3(1) | data>SD3(2))); % empty


%Masking
data=[3.2, 3.4, 3.7, 3.7, 3.8, 3.9, 4, 4, 4.1, 4.2, 4.7, 4.8, 14, 15, 40];
m=mean(data);
s=std(data); %In this case we are using the unbiased estimator of standard deviation
SD2=[m-2*s,m+2*s];
SD3=[m-3*s,m+3*s];
% Function that detects the outliers with 2SD or 3SD
outliers2SD=data((data<SD2(1) | data>SD2(2))); % only 40
outliers3SD=data((data<SD3(1) | data>SD3(2))); % only 40


