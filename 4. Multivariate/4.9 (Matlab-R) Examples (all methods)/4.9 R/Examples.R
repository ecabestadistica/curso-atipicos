install.packages("mrfDepth")
library(mrfDepth)
library(robustbase)

############################# Hawkin-Bradu-Kass dataset ###################
data(hbk)
hbk.x=data.matrix(hbk[, 1:3])

#From package rrcov
#Cov classic
cc <- CovClassic(hbk.x)
plot(cc, which="pairs")
plot(cc, which="distance")

#Stahel-Donoho estimator
c=CovSde(hbk.x)
plot(c)
plot(c, which="pairs")
plot(c, which="xydist")

#MCD
MCDe <- CovMcd(hbk.x)
plot(MCDe)
plot(MCDe, which="pairs")
plot(MCDe, which="xydist")

#Adjusted MCD (mvoutlier)
install.packages("mvoutlier")
library(mvoutlier)
m=aq.plot(hbk.x)
uni.plot(hbk.x,symb=TRUE)
colorData <- color.plot(hbk.x[,c(1,2)])
#Outliers
indexes=1:75
out=indexes[m$outliers]
out


#OGK
Ogk <- CovOgk(hbk.x)
plot(Ogk)
plot(Ogk, which="pairs")
plot(Ogk, which="xydist")

