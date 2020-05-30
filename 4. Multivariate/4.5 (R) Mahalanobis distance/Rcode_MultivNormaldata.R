set.seed(2)
#Generating multivariate Normal data 
mu=c(5,3) #mean
Sigma=matrix(c(10,3,3,2),2,2) #cov matrix (covariance=3)
mvn=mvrnorm(n = 100, mu, Sigma)
plot(mvn)

# Compute the sample mean and sample covariance matrix
clcenter <- colMeans(mvn)
clcov <- cov(mvn)

# Add 97.5% tolerance ellipsoid (and 50% and 25%)
install.packages("mixtools")
library(mixtools)
ellipse(mu = clcenter, sigma = clcov, alpha = 0.025,col = "blue", lty = 2)
ellipse(mu = clcenter, sigma = clcov, alpha = 0.5,col = "red", lty = 3)
ellipse(mu = clcenter, sigma = clcov, alpha = 0.25,col = "green", lty = 3)

#Zoom the plot
install.packages("zoom")
library(zoom)
zm()

#Introducing the outlier
set.seed(4)
out1=rnorm(20,mean=8,sd=1)
set.seed(5)
out2=rnorm(20,mean=-1,sd=1)
out=cbind(out1,out2)

#How it should be
plot(mvn)
ellipse(mu = clcenter, sigma = clcov, alpha = 0.025,col = "blue", lty = 2)
points(out1, out2, col = "red")
#Zoom the plot
zm()

#Calculate mean and Sigma with contaminated data
data_O=rbind(mvn,out)
clcenter_o <- colMeans(data_O)
clcov_o <- cov(data_O)
plot(data_O)
ellipse(mu = clcenter_o, sigma = clcov_o, alpha = 0.025,col = "blue", lty = 2)
#Zoom the plot
zm()


