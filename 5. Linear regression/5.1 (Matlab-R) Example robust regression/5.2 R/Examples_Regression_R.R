#Star data
data(starsCYG, package="robustbase")
View(starsCYG)
plot(starsCYG)


#Least squares
lm.stars <- lm(log.light ~ log.Te, data = starsCYG)
summary(lm.stars)

#Least trimmed squares LTS
lts.stars <- ltsReg(log.light ~ log.Te, data = starsCYG)
summary(lts.stars)


#LMS
library(MASS)
lms.stars=lqs(starsCYG$log.light, starsCYG$log.Te,method="lms")
summary(lms.stars)


#LAD
install.packages("L1pack")
library(L1pack)
lad.stars <- l1fit(starsCYG$log.light, starsCYG$log.Te)
summary(lad.stars)

#plot
plot(starsCYG)
abline(lm.stars, lty=2, lwd=2, col="green")
abline(lad.stars, lty=2, lwd=2, col="magenta")
abline(lms.stars, lty=4, lwd=2, col="red")
abline(lts.stars, lty=4, lwd=2, col="blue")
legend("bottomleft", c("LS","LAD","LMS","LTS"),inset=0.02, lty=c(2,2,4,4), lwd=2, col=c("green","magenta", "red","blue"))
