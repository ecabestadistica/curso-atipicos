x1=c(1,2,3,4,5,6,7)
m1=mean(x1)
median1=median(x1)
v1=var(x1)
error1=qnorm(0.975)*sqrt(v1/length(x1))
left1=m1-error1
right1=m1+error1
ci1=c(left1,right1)


x2=c(1,2,3,4,5,6,77)
m2=mean(x2)
median2=median(x2)
v2=var(x2)
error2=qnorm(0.975)*sqrt(v2/length(x2))
left2=m2-error2
right2=m2+error2
ci2=c(left2,right2)