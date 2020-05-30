library(stats)
install.packages("mrfDepth")
library(mrfDepth)
data("cardata90")
plot(cardata90)

w=as.double(cardata90$Weight) 
d=as.double(cardata90$Disp.)
data=cbind(w,d)

#Note now the correlation matrix
install.packages("Hmisc")
library(Hmisc)
rc=rcorr(data)
rc$r[1,2] #The correlation is 0.80 

#Comedian between Weight and Disp
com=median((w-median(w))*(d-median(d)))
mad1=median(abs(w-median(w)))
mad2=median(abs(d-median(d)))
#Correlation median coeff
delta=com/(mad1*mad2)
delta #The comedian is 0.87 



