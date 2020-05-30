library(stats)
load("stdata.Rdata")

plot(stdata) #Note the outlier in the lower right corner

#Mean of the 19 observations (without the outlier)
m19=colMeans(stdata[1:19,])
#Mean of the 20 observations
m20=colMeans(stdata[1:20,])
#There was no significant differences between the two mean vectors.

#But note now the correlation matrices
install.packages("Hmisc")
library(Hmisc)
r19=rcorr(stdata[1:19,])
r19$r
r20=rcorr(stdata[1:20,])
r20$r
#The real correlation (without the outlier) in our data is almost the double of that of the complete data

#Comedian 20 obs
com=median((stdata[,1]-median(stdata[,1]))*(stdata[,2]-median(stdata[,2])))
mad1=median(abs(stdata[,1]-median(stdata[,1])))
mad2=median(abs(stdata[,2]-median(stdata[,2])))
delta=com/(mad1*mad2)



