set.seed(3)
library(MASS)
install.packages("depth")
library(depth)

mu1 <- c(0,0); mu2 <- c(10,0); sigma <- matrix(c(1,0,0,1), nc = 2)
X <- rbind(mvrnorm(80, mu1, sigma), mvrnorm(20, mu2, sigma)) #dimension 100x2
plot(X)

# Mean vector 
m=c(mean(X[,1]),mean(X[,2]))
# Component-wise median
med1=c(median(X[,1]),median(X[,2]))
# Spatial median
med2=med(X,method="Spatial")


