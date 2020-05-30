library(stats)
x=c(1,2,3,4,5)
xo=c(1,2,3,4,50)
n=5

#Standard deviation
factor=sqrt((n-1)/n) #correction factor for the standard deviation, without the factor is the unbiased estimator.
std1=factor*sd(x)
std2=factor*sd(xo)
  
#MAD
mad1=mad(x,     constant = 1) #if the distribution is Normal let the default option which is  constant = 1.4826 (same as not putting any constant option). 
mad2=mad(xo,     constant = 1) 
