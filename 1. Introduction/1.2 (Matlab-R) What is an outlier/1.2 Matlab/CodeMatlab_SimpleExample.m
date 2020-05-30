%Example of outliers in univariate data 

x1=[1 2 3 4 5 6 7];
m1=mean(x1);
median1=median(x1);
var1=var(x1);
x1plus=m1+norminv(0.975,0,1)*sqrt(var1)*(1/sqrt(length(x1)));
x1minus=m1-norminv(0.975,0,1)*sqrt(var1)*(1/sqrt(length(x1)));
ci1=[x1minus x1plus]

%Replace observation 7 with 77
x2=[1 2 3 4 5 6 77];
m2=mean(x2);
median2=median(x2);
var2=var(x2);
x2plus=m2+norminv(0.975,0,1)*sqrt(var2)/sqrt(length(x2));
x2minus=m2-norminv(0.975,0,1)*sqrt(var2)/sqrt(length(x2));
ci2=[x2minus x2plus]
