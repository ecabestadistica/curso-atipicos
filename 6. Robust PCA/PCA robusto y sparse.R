#-----------------------------------------------------------------------------
# Datos multivariantes con atípicos

library(mvtnorm)
install.packages("pcaPP")
library(pcaPP)

x <- rbind(rmvnorm(200, rep(0, 6), diag(c(5, rep(1,5)))),
           rmvnorm( 15, c(0, rep(20, 5)), diag(rep(1, 6))))

# Calculamos los componentes con PCAproj
pc1 <- PCAproj(x, 6)

# Biplot:
biplot(pc1)

# Otra función objetivo y los 2 primeros PC's
pc2 <- PCAproj(x, 3, "qn", "sphere")
biplot(pc2)

#PCAgrid
pc3 <- PCAgrid(x, k=6)
biplot(pc3)


#--------------------------------------------------------------
set.seed(0)
x <- data.Zou() #Test Data Generation for Sparse PCA examples

## PCA clasico
pc <- princomp (x)

biplot (pc, main = "non-sparse PCs")


#PCAgrid
pcg <- PCAgrid(x)
biplot (pcg, main = "PCAgrid")

#----------------------------------------------
# Sparse PCA
#Necesitamos un parámetro lambda que mide la fuerza de la restricción de dispersión 
#(solo para sPCAgrid). Un valor único para todos los componentes, o un vector de 
#longitud k con diferentes valores para cada componente. La función opt.TPO  
#calcula una sugerencia para el parámetro lambda.

## Calculando el lambda con opt.TPO 
set.seed(0)
k.max <- 3 ## numero max de componentes sparse
## argumentos para el algoritmo sPCAgrid 
maxiter <- 25 ## numero maximo de iteraciones
method <- "sd" ## estimador clasico

## Criterio TPO 
oTPO <- opt.TPO (x, k.max = k.max, method = method, maxiter = maxiter)
oTPO$pc ## el modelo seleccionado por opt.TPO
oTPO$pc$load ## Y los sparse loadings

#Escogemos estos tres lambda para los tres PC
objlambda=oTPO$pc
objlambda$lambda
lambda <- c (0.23, 0.34, 0.003)

## Sparse PCA con sPCAgrid
spc <- sPCAgrid (x, k = 3, lambda = lambda, method = "sd")

## No-sparse loadings
unclass (pc$load[,1:3])
pc$sdev[1:3]

#Los loadings sparse
unclass (spc$load)
spc$sdev[1:3]

## comparing the non-sparse and sparse biplot
par (mfrow = 1:2)
biplot (pc, main = "non-sparse PCs")
biplot (spc, main = "sparse PCs")



#---------------------------------------------------------------------

install.packages("rospca")
library(rospca)

#Generar sparse data con outliers usando dataGen
#m: número de datasets
#n: número de observaciones
#p: número de variables
#eps: proporción de contaminación (entre 0 y 0.5)

X_all <- dataGen(m=1, n=100, p=10, eps=0.2)
X <- X_all$data[[1]]
resR <- robpca(X, k=2)
diagPlot(resR)

resRS <- rospca(X, k=2, lambda=0.4, stand=TRUE)
diagPlot(resRS)

#Outliers by the method robpca
out=which(resR$flag.all== FALSE)
#Real outliers
realout=X_all$ind
cat("Outliers by the method robpca:", sort(unname(out)))
cat("Real Outliers", sort(realout[[1]]))

#Outliers by the method rospca
out=which(resRS$flag.all== FALSE)
cat("Outliers by the method rospca:", sort(unname(out)))
cat("Real Outliers", sort(realout[[1]]))

cat("Outliers by the method robpca:", sort(unname(out)))
cat("Outliers by the method rospca:", sort(unname(out)))


resR$loadings
resRS$loadings
