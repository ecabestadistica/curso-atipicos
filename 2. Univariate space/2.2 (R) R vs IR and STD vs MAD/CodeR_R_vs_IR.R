library(stats)
library(base)
x=c(1,2,3,4,5)
xo=c(1,2,3,4,50)

#Range
r1=diff(range(x)) #range returns the max and the mean, diff makes the difference between the two
r2=diff(range(xo))

#Intercuartile Range
iqr1=IQR(x) 
iqr2=IQR(xo)
