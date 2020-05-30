%% Case1
data=[3.2, 3.4, 3.7, 3.7, 3.8, 3.9, 4, 4, 4.1, 4.2, 4.7, 4.8, 14, 15];
m=median(data);
ma=mad(data,1);
made=1.483*ma;
Mi=(data-m*ones(1,length(data)))./made;
Interval=[-3.5,3.5];
% Function that detects the outliers 
outliers3SD=data((Mi<Interval(1) | Mi>Interval(2))); % 14 and 15
