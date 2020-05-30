## Load the data from MASS package (install the package if you have not done so)
data(Animals, package = "MASS")
View(Animals)
data=log(Animals)
plot(data)

#Sample mean and sample covariance matrix estimators
clcenter=colMeans(data)
clcov=cov(data)

#Ellipse 97.5% with classical estimators
install.packages("mixtools")
library(mixtools)
ellipse(mu = clcenter, sigma = clcov, alpha = 0.025,col = "blue", lty = 2)

#MCD estimators
library(robustbase)
res=covMcd(data)
mcdcenter=res$center
mcdcov=res$cov

#Ellipse 97.5% with robust MCD estimators
ellipse(mu = mcdcenter, sigma = mcdcov, alpha = 0.025,col = "red", lty = 2)

#Zoom
install.packages("zoom")
library(zoom)
zm()

