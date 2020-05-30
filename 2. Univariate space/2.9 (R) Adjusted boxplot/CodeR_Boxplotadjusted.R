library("robustbase")
data=c(3.2, 3.4, 3.7, 3.7, 3.8, 3.9, 4, 4, 4.1, 4.2, 4.7, 4.8, 14, 15)
data=sort(data)
n=length(data)
m=mc(data) #0.4
n4=floor((n + 3)/2)/2
d <- c(1, n4, (n + 1)/2, n + 1 - n4, n)
q=0.5 * (data[floor(d)] + data[ceiling(d)])
q1=q[2]
q3=q[4]
ri=q3-q1

if (m>0) {
  L=q1-(1.5*exp(-3.5*m)*ri)
  U=q3+(1.5*exp(4*m)*ri)
}

if (m<=0){
  L=q1-(1.5*exp(-4*m)*ri)
  U=q3+(1.5*exp(3.5*m)*ri)
}



#Plotting the boxplot using package robustbase
adjbox(data,range = 1.5, a = -3.5, b = 4)
statsb=adjboxStats(data,coef = 1.5, a = -3.5, b = 4)
fences=statsb$fence
outix=which(data > statsb$fence[2] | data < statsb$fence[1])
obs=data[outix]
print(paste0("There are: ", length(obs)," Outliers"))
print(paste0("They are:", paste(obs, collapse = ",")))


