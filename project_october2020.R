#plot of densitites
plot(density(data_7_$feb))
plot(density(data_7_$oct))

#checking for normality
shapiro.test(data_7_$oct)
shapiro.test(data_7_$feb)

library("boot")
set.seed(1001)

####quantiles and ci for feb####
x=data_7_$feb
x=as.vector(x)
b <- function(x,i){
  quantile = quantile(x[i])
  return(quantile)
}

bs = boot(x,b,R=1000)
bs
bs[["t"]] # view bootstrap samples
s=summary(bs[["t"]]) #to find mean of each quantile for bootstrap samples
s


v50=var(bs$t[,3])
v25=var(bs$t[,2])
v75=var(bs$t[,4])

quantile(x)
ci25=c(7817.550-1.96*sqrt(v25),7817.550+1.96*sqrt(v25))
ci25

ci50=c(7973.225-1.96*sqrt(v50),7973.225+1.96*sqrt(v50))
ci50

ci75=c(8149.975-1.96*sqrt(v75),8149.975+1.96*sqrt(v75))
ci75

####quantiles and ci for oct####
y=data_7_$oct
y=as.vector(y)
b <- function(y,i){
  quantile = quantile(y[i])
  return(quantile)
}

ps = boot(y,b,R=1000)
ps
ps[["t"]] # view bootstrap samples
s2=summary(ps[["t"]]) #to find mean of each quantile for bootstrap samples
s2

vp50=var(ps$t[,3])#var of 50th percentile
vp50

vp25=var(ps$t[,2]) #var of 25th percentile
vp25

vp75=var(ps$t[,4]) #var of 75th percentile
vp75

quantile(y)
ci25=c(8034.125-1.96*sqrt(vp25),8034.125+1.96*sqrt(vp25))
ci50=c(8093.800-1.96*sqrt(vp50),8093.800+1.96*sqrt(vp50))
ci75=c(8147.438-1.96*sqrt(vp75),8147.438+1.96*sqrt(vp75))
ci25
ci50
ci75

####ci for diff between 2 1st quartiles####
quantile(x)
quantile(y)
v25
vp25
ci_diff_25=c((7817.550-8034.125)-1.96*sqrt(v25+vp25),(7817.550-8034.125)+1.96*sqrt(v25+vp25))
ci_diff_25

v50
vp50
ci_diff_50=c((7973.225-8093.800)-1.96*sqrt(v50+vp50),(7973.225-8093.800)+1.96*sqrt(v50+vp50))
ci_diff_50

v75
vp75
ci_diff_75=c((8149.975-8147.438)-1.96*sqrt(v75+vp75),(8149.975-8147.438)+1.96*sqrt(v75+vp75))
ci_diff_75

#identity matrix for bootstrap sample
t=diag(x=1,nrow=1000,ncol=1000)

#feb
set.seed(1001)
m=bs[["t"]]
Combined=c(m[,2],m[,3],m[,4])
q_n=matrix(data = Combined,ncol=3,byrow = FALSE)
q_n
#transpose

qt_n=t(q_n)
qt_n
dim(qt_n)

IB=diag(x=1,nrow = 1000,ncol = 1000)
IB

B=1000

I=rep(1,1000)
E=matrix(I, nrow = 1000, ncol = 1)
E1=matrix(I, nrow = 1, ncol = 1000)

E2=E%*%E1
E2

E3=E2/1000
E3

#INSIDE BRACKET
E4=IB-E3

E5=qt_n%*%E4%*%q_n
E5/999
V=E5/999
V

#oct
set.seed(1001)
n=ps[["t"]]
Combined=c(n[,2],n[,3],n[,4])
p_n=matrix(data=Combined,ncol=3,byrow = FALSE)
p_n
dim(p_n)
#transpose
pt_n=t(p_n)
pt_n
dim(pt_n)

#check!!
pt_n1=matrix(data = pt_n,ncol = 3,byrow = FALSE)
pt_n1
dim(pt_n1)

IB=diag(x=1,nrow = 1000,ncol = 1000)
IB

B=1000

I=rep(1,1000)
P=matrix(I, nrow = 1000, ncol = 1)
P1=matrix(I, nrow = 1, ncol = 1000)

P2=P%*%P1
P2

P3=P2/1000
P3

#INSIDE BRACKET
P4=IB-P3

P5=pt_n%*%P4%*%p_n
P5/999
VP=P5/999
VP

#
B=rep(0,9)
Q=matrix(data=B,ncol=3)
Q

C1=cbind(V,Q)
C2=cbind(Q,VP)
M=rbind(C1,C2)
M
class(M)
a1=c(1,0,0,-1,0,0)
a2=c(0,1,0,0,-1,0)
a3=c(0,0,1,0,0,-1)
A=matrix(data=c(a1,a2,a3),nrow=3,byrow =TRUE)
A

xq=quantile(x)
yq=quantile(y)
xq
yq
q_1=matrix(data=c( 7817.550, 7973.225, 8149.97,8034.125 ,8093.800, 8147.438),nrow=1)
q_1
#transpose
A1=t(A)
A1
q=t(q_1)
q
# wald test
N=A%*%M%*%A1 
N

library(matlib)
N1=inv(N)


N1
N%*%N1

W=q_1%*%A1%*%N1%*%A%*%q
W


#Skewed Distribution effect upon the bootstrap estimates of variance
####replicate samples####
#N(0,1)
#n=20
rnorm(20)

u_prob=c()
for (i in 1:1000)
{
  a1=rnorm(20)
  u1=sort(sample(a1,20))[6]
  u2=sort(sample(a1,20))[11]
  u3=sort(sample(a1,20))[16]
  u_prob=rbind(u_prob,c(i,u1,u2,u3))
}
u_prob

vbar2025=var(u_prob[,2])
vbar2050=var(u_prob[,3])
vbar2075=var(u_prob[,4])
c2012=cov(u_prob[,2],u_prob[,3])
c2023=cov(u_prob[,4],u_prob[,3])
c2013=cov(u_prob[,2],u_prob[,4])


#N(0,1)
#n=40
rnorm(40)
u_prob40=c()
for (i in 1:1000)
{
  a2=rnorm(40)
  u401=sort(sample(a2,40))[11]
  u402=sort(sample(a2,40))[21]
  u403=sort(sample(a2,40))[31]
  u_prob40=rbind(u_prob40,c(i,u401,u402,u403))
}
u_prob40

vbar4025=var(u_prob40[,2])
vbar4050=var(u_prob40[,3])
vbar4075=var(u_prob40[,4])
c4012=cov(u_prob40[,2],u_prob40[,3])
c4023=cov(u_prob40[,4],u_prob40[,3])
c4013=cov(u_prob40[,2],u_prob40[,4])


#N(0,1)
#n=60

a60=rnorm(60)
u_prob60=c()
for (i in 1:1000)
{
  a3=rnorm(60)
  u601=sort(sample(a3,60))[16]
  u602=sort(sample(a3,60))[31]
  u603=sort(sample(a3,60))[46]
  u_prob60=rbind(u_prob60,c(i,u601,u602,u603))
}
u_prob60

vbar6025=var(u_prob60[,2])
vbar6050=var(u_prob60[,3])
vbar6075=var(u_prob60[,4])
c6012=cov(u_prob60[,2],u_prob60[,3])
c6023=cov(u_prob60[,4],u_prob60[,3])
c6013=cov(u_prob60[,2],u_prob60[,4])

#N(0,1)
#n=80

a80=rnorm(80)
u_prob80=c()
for (i in 1:1000)
{
  a4=rnorm(80)
  u801=sort(sample(a4,80))[21]
  u802=sort(sample(a4,80))[41]
  u803=sort(sample(a4,80))[61]
  u_prob80=rbind(u_prob80,c(i,u801,u802,u803))
}
u_prob80

vbar8025=var(u_prob80[,2])
vbar8050=var(u_prob80[,3])
vbar8075=var(u_prob80[,4])
c8012=cov(u_prob80[,2],u_prob80[,3])
c8023=cov(u_prob80[,4],u_prob80[,3])
c8013=cov(u_prob80[,2],u_prob80[,4])


#N(0,1)
#n=100

a100=rnorm(100)
u_prob100=c()
for (i in 1:1000)
{
  a5=rnorm(100)
  u1001=sort(sample(a5,100))[26]
  u1002=sort(sample(a5,100))[51]
  u1003=sort(sample(a5,100))[76]
  u_prob100=rbind(u_prob100,c(i,u1001,u1002,u1003))
}
u_prob100

vbar10025=var(u_prob100[,2])
vbar10050=var(u_prob100[,3])
vbar10075=var(u_prob100[,4])
c10012=cov(u_prob100[,2],u_prob100[,3])
c10023=cov(u_prob100[,4],u_prob100[,3])
c10013=cov(u_prob100[,2],u_prob100[,4])

#N(0,1)
#n=150

a150=rnorm(150)
u_prob150=c()
for (i in 1:1000)
{
  a=rnorm(150)
  u1501=sort(sample(a,150))[38]
  u1502=sort(sample(a,150))[76]
  u1503=sort(sample(a,150))[113]
  u_prob150=rbind(u_prob150,c(i,u1501,u1502,u1503))
}
u_prob150

vbar15025=var(u_prob150[,2])
vbar15050=var(u_prob150[,3])
vbar15075=var(u_prob150[,4])
c15012=cov(u_prob150[,2],u_prob150[,3])
c15023=cov(u_prob150[,4],u_prob150[,3])
c15013=cov(u_prob150[,2],u_prob150[,4])


#N(0,1)
#n=200

a200=rnorm(200)
u_prob200=c()
for (i in 1:1000)
{
  a6=rnorm(200)
  u2001=sort(sample(a6,200))[51]
  u2002=sort(sample(a6,200))[101]
  u2003=sort(sample(a6,200))[151]
  u_prob200=rbind(u_prob200,c(i,u2001,u2002,u2003))
}
u_prob200

vbar20025=var(u_prob200[,2])
vbar20050=var(u_prob200[,3])
vbar20075=var(u_prob200[,4])
c20012=cov(u_prob200[,2],u_prob200[,3])
c20023=cov(u_prob200[,4],u_prob200[,3])
c20013=cov(u_prob200[,2],u_prob200[,4])



####boot samples####
library(boot)
# for sample 40

a40=rnorm(40)
b40 <- function(a40,i){
  quantile = quantile(a40[i])
  return(quantile)
}

ab40 = boot(a40,b40,R=1000)
ab40
ab40[["t"]]
v4025=var(ab40$t[,2])
v4050=var(ab40$t[,3])
v4075=var(ab40$t[,4])
cb4012=cov(ab40$t[,2],ab40$t[,3])
cb4013=cov(ab40$t[,2],ab40$t[,4])
cb4023=cov(ab40$t[,3],ab40$t[,4])

# for sample 20

a=rnorm(20)
b20 <- function(a,i){
  quantile = quantile(a[i])
  return(quantile)
}

ab20 = boot(a,b20,R=1000)
ab20
ab20[["t"]]
v2025=var(ab20$t[,2])
v2050=var(ab20$t[,3])
v2075=var(ab20$t[,4])
cb2012=cov(ab20$t[,2],ab20$t[,3])
cb2013=cov(ab20$t[,2],ab20$t[,4])
cb2023=cov(ab20$t[,3],ab20$t[,4])


# for sample 60

b60 <- function(a60,i){
  quantile = quantile(a60[i])
  return(quantile)
}

ab60 = boot(a60,b60,R=1000)
ab60
ab60[["t"]]
v6025=var(ab60$t[,2])
v6050=var(ab60$t[,3])
v6075=var(ab60$t[,4])
cb6012=cov(ab60$t[,2],ab60$t[,3])
cb6013=cov(ab60$t[,2],ab60$t[,4])
cb6023=cov(ab60$t[,3],ab60$t[,4])


# for sample 80

b80 <- function(a80,i){
  quantile = quantile(a80[i])
  return(quantile)
}

ab80 = boot(a80,b80,R=1000)
ab80
ab80[["t"]]
v8025=var(ab80$t[,2])
v8050=var(ab80$t[,3])
v8075=var(ab80$t[,4])

cb8012=cov(ab80$t[,2],ab80$t[,3])
cb8013=cov(ab80$t[,2],ab80$t[,4])
cb8023=cov(ab80$t[,3],ab80$t[,4])

# for sample 100

b100 <- function(a100,i){
  quantile = quantile(a100[i])
  return(quantile)
}

ab100 = boot(a100,b100,R=1000)
ab100
ab100[["t"]]
v10025=var(ab100$t[,2])
v10050=var(ab100$t[,3])
v10075=var(ab100$t[,4])
cb10012=cov(ab100$t[,2],ab100$t[,3])
cb10013=cov(ab100$t[,2],ab100$t[,4])
cb10023=cov(ab100$t[,3],ab100$t[,4])


# for sample 150

b150 <- function(a150,i){
  quantile = quantile(a150[i])
  return(quantile)
}

ab150 = boot(a150,b150,R=1000)
ab150
ab150[["t"]]
v15025=var(ab150$t[,2])
v15050=var(ab150$t[,3])
v15075=var(ab150$t[,4])
cb15012=cov(ab150$t[,2],ab150$t[,3])
cb15013=cov(ab150$t[,2],ab150$t[,4])
cb15023=cov(ab150$t[,3],ab150$t[,4])

# for sample 200

b200 <- function(a200,i){
  quantile = quantile(a200[i])
  return(quantile)
}

ab200 = boot(a200,b200,R=1000)
ab200
ab200[["t"]]
v20025=var(ab200$t[,2])
v20050=var(ab200$t[,3])
v20075=var(ab200$t[,4])
cb20012=cov(ab200$t[,2],ab200$t[,3])
cb20013=cov(ab200$t[,2],ab200$t[,4])
cb20023=cov(ab200$t[,3],ab200$t[,4])


####relative error####
#re=(vhat-vbar)/vbar

#for n=20
re2025=(v2025-vbar2025)/vbar2025
re2050=(v2050-vbar2050)/vbar2050
re2075=(v2075-vbar2075)/vbar2075
cre2012=(cb2012-c2012)/c2012
cre2013=(cb2013-c2013)/c2013
cre2023=(cb2023-c2023)/c2023
re2025
re2050
re2075
cre2012
cre2013
cre2023

#for n=40
re4025=(v4025-vbar4025)/vbar4025
re4050=(v4050-vbar4050)/vbar4050
re4075=(v4075-vbar4075)/vbar4075
cre4012=(cb4012-c4012)/c4012
cre4013=(cb4013-c4013)/c4013
cre4023=(cb4023-c4023)/c4023
re4025
re4050
re4075
cre4012
cre4013
cre4023

#for n=60
re6025=(v6025-vbar6025)/vbar6025
re6050=(v6050-vbar6050)/vbar6050
re6075=(v6075-vbar6075)/vbar6075
cre6012=(cb6012-c6012)/c6012
cre6013=(cb6013-c6013)/c6013
cre6023=(cb6023-c6023)/c6023
re4025
re4050
re4075
cre4012
cre4013
cre4023

#for n=80
re8025=(v8025-vbar8025)/vbar8025
re8050=(v8050-vbar8050)/vbar8050
re8075=(v8075-vbar8075)/vbar8075
cre8012=(cb8012-c8012)/c8012
cre8013=(cb8013-c8013)/c8013
cre8023=(cb8023-c8023)/c8023
re8025
re8050
re8075
cre8012
cre8013
cre8023

#for n=100
re10025=(v10025-vbar10025)/vbar10025
re10050=(v10050-vbar10050)/vbar10050
re10075=(v10075-vbar10075)/vbar10075
cre10012=(cb10012-c10012)/c10012
cre10013=(cb10013-c10013)/c10013
cre10023=(cb10023-c10023)/c10023
re10025
re10050
re10075
cre10012
cre10013
cre10023

#for n=150
re15025=(v15025-vbar15025)/vbar15025
re15050=(v15050-vbar15050)/vbar15050
re15075=(v15075-vbar15075)/vbar15075
cre15012=(cb15012-c15012)/c15012
cre15013=(cb15013-c15013)/c15013
cre15023=(cb15023-c15023)/c15023
re15025
re15050
re15075
cre15012
cre15013
cre15023

#for n=200
re20025=(v20025-vbar20025)/vbar20025
re20050=(v20050-vbar20050)/vbar20050
re20075=(v20075-vbar20075)/vbar20075
cre20012=(cb20012-c20012)/c20012
cre20013=(cb20013-c20013)/c20013
cre20023=(cb20023-c20023)/c20023
re20025
re20050
re20075
cre20012
cre20013
cre20023


####table####
r=cbind(re2025,re2050,re2075,cre2012,cre2023,cre2013)
r=rbind(r,cbind(re4025,re4050,re4075,cre4012,cre4023,cre4013))
r=rbind(r,cbind(re6025,re6050,re6075,cre6012,cre6023,cre6013))
r=rbind(r,cbind(re8025,re8050,re8075,cre8012,cre8023,cre8013))
r=rbind(r,cbind(re10025,re10050,re10075,cre10012,cre10023,cre10013))
r=rbind(r,cbind(re15025,re15050,re15075,cre15012,cre15023,cre15013))
r=rbind(r,cbind(re20025,re20050,re20075,cre20012,cre20023,cre20013))
r
