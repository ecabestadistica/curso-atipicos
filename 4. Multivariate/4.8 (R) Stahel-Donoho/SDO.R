#Stahel-Donoho
#Computes the Stahel-Donoho outlyingness (SDO) of p-dimensional points z relative to a p-dimensional dataset X
install.packages("mrfDepth")
library(mrfDepth)
library(robustbase)

# Compute the outlyingness of a simple two-dimensional dataset.
# Outliers are plotted in red.
BivData=log(robustbase::Animals2)
Result=outlyingness(x = BivData)
IndOutliers=which(!Result$flagX) #flagX=TRUE if the obs is not outlier, FALSE if it is outlier
plot(BivData)
points(BivData[IndOutliers,], col = "red")
#Compute a robust estimate of location and scale using the Stahel-Donoho projection based estimator
install.packages("rrcov")
library(rrcov)
CovSde(BivData)

#Simulated example 
BivData <- matrix(rnorm(120), ncol = 2)
BivData <- rbind(BivData, matrix(c(6,6, 6, -2), ncol = 2))
Result=outlyingness(x = BivData)
IndOutliers=which(!Result$flagX) #flagX=TRUE if the obs is not outlier, FALSE if it is outlier
plot(BivData)
points(BivData[IndOutliers,], col = "red")





