%% Case1
data=[3.2, 3.4, 3.7, 3.7, 3.8, 3.9, 4, 4, 4.1, 4.2, 4.7, 4.8, 14, 15];
boxplot(data,'Orientation','horizontal')
q1=prctile(data, 25);
q2=median(data);
q3=prctile(data, 75);
ri=q3-q1;
mi=min(data);
ma=max(data);
% First fences
f1=q1-1.5*ri;
f2=q3+1.5*ri;
conditions=[mi<f1  ma>f2];
% If "conditions" is equal to 0 in either condition, it means the expression
% does not holds, and if it is equal to one it means that condition holds.
% In this case second condition (max>b2) holds because f2=6.2 and value 14
% and 15 are higher.

% Second fences
of1=q1-3*ri
of2=q3+3*ri
conditions=[mi<of1  ma>of2]
% If "conditions" is equal to 0 in either condition, it means the expression
% does not holds, and if it is equal to one it means that condition holds.
% In this case second condition (max>b2) holds again because of2=7.7 and value 14
% and 15 are higher.


%% Case2 (small sample size)
data=[1450, 1470, 2290, 2930, 4180, 15800,29200]
boxplot(data) %Default orientation is vertical


