## Load the data from MASS package (install the package if you have not done so)
data(Animals, package = "MASS")
View(Animals)

## Regression plot:
plotbb <- function(bbdat) {
  d.name <- deparse(substitute(bbdat))
  plot(log(brain) ~ log(body), data = bbdat, main = d.name)
  abline( lm(log(brain) ~ log(body), data = bbdat))
  abline(MASS::rlm(log(brain) ~ log(body), data = bbdat), col = 2)
  legend("bottomright", leg = c("lm", "rlm"), col=1:2, lwd=1, inset = 1/20)
}


data(Animals, package = "MASS")
plotbb(bbdat = Animals)