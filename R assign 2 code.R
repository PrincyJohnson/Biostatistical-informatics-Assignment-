setwd("C:/Users/rraag/Documents/R")
mydata <- read.table("assignII2020-1.txt", header = T, row.names = 1, sep = 
                       "\t") 
mydata
install.packages("survival")
library(survival)
library(Hmisc)
summary(mydata)
Hmisc::describe(mydata)

#Question 1
###########Median survival of RFS##################################
mediansurvival <- survfit(Surv(mydata$RFS, mydata$RFSStatus) ~ 1)
mediansurvival #no of events is 296
#no of events on the basis of BarrettsPrevious
B_yes <- mydata[mydata$BarrettsPrevious== "Yes",] ####Yes
B_yes
event_Byes <- survfit(Surv(B_yes$RFS, B_yes$RFSStatus)~1)
event_Byes
B_no <- mydata[mydata$BarrettsPrevious== "No",] #####No
B_no
event_Bno <- survfit(Surv(B_no$RFS, B_no$RFSStatus)~1)
event_Bno
####no of events on the basis of sex 
male <- mydata[mydata$Sex == "M",]
male
event_male <-survfit(Surv(male$RFS, male$RFSStatus)~1)
event_male
female <- mydata[mydata$Sex == "F",]
event_female <-survfit(Surv(female$RFS, female$RFSStatus)~1)
event_female
####no of events on the basis of grade
High <- mydata[mydata$Grade == "HighGrade",]
High
event_high <- survfit(Surv(High$RFS, High$RFSStatus)~1)
event_high
Low <- mydata[mydata$Grade == "LowGrade",]
Low
event_low <- survfit(Surv(Low$RFS, Low$RFSStatus)~1)
event_low
#####no of events on the basis of tumour stage
T1 <- mydata[mydata$TumourStage == "1",]
T1
event_T1 <- survfit(Surv(T1$RFS, T1$RFSStatus)~1)
event_T1
T2 <- mydata[mydata$TumourStage == "2",]
T2
event_T2 <- survfit(Surv(T2$RFS, T2$RFSStatus)~1)
event_T2
T3 <- mydata[mydata$TumourStage == "3",]
T3
event_T3 <- survfit(Surv(T3$RFS, T3$RFSStatus)~1)
event_T3


#QUESTION 2:
#2a
barretts.surv <- survfit(Surv(mydata$RFS, mydata$RFSStatus)~BarrettsPrevious,
                         data = mydata, conf.int=0)
barretts.surv
plot(barretts.surv, mark.time = T, main= "RFS: Barrett's Previous", 
     col.main= "darkred", xlab = "Time in days", ylab = "RFS probability", 
     col.lab= "blue4",
     cex.lab= 0.8, lty= 2:4, col= c("deeppink", "blue"))
legend(2000,1, title = "Legend", c("No", "Yes"), col=c("deeppink", "blue"), 
       lty=2:4, lwd = 2,cex=0.5)
survdiff(Surv(mydata$RFS, mydata$RFSStatus)~BarrettsPrevious, data=mydata)

#2b
sex.surv <- survfit(Surv(mydata$RFS, mydata$RFSStatus)~Sex, data = mydata, 
                    conf.int=0)
sex.surv
ggsurvplot(sex.surv,data= mydata, pval = T)
plot(sex.surv, mark.time = T, main= "RFS: Sex", 
     col.main= "darkred", xlab = "Time (days)", ylab = "probability of RFS", 
     col.lab= "blue4",
     cex.lab= 0.8, lty= 2:4, col= c("deeppink", "blue"))
legend(2000,1, title = "Legend", c("Female", "Male"), col=c("deeppink", 
                                                            "blue"), lty=2:4,cex=0.5)
survdiff(Surv(mydata$RFS, mydata$RFSStatus)~ Sex, data = mydata)

#2c
grade.surv <- survfit(Surv(mydata$RFS, mydata$RFSStatus)~Grade, data = 
                        mydata, conf.int=0)
grade.surv
ggsurvplot(grade.surv,data=mydata, pval = T)
plot(grade.surv, mark.time = T, main= "RFS: Grade", 
     col.main= "darkred", xlab = "Time (days)", ylab = "probability of 
RFS", col.lab= "blue4",
     cex.lab= 0.8, lty= 2:4, col= c("deeppink", "blue"))
legend(2000,1, title = "Legend", c("High", "Low"), col=c("deeppink", 
                                                         "blue"), lty=2:4, cex=0.5)
survdiff(Surv(mydata$RFS, mydata$RFSStatus)~Grade, data = mydata)

#2d
stage.surv <- survfit(Surv(mydata$RFS, mydata$RFSStatus)~TumourStage, data = 
mydata,conf.int=0.95)
stage.surv
ggsurvplot(stage.surv,data=mydata, pval = T)
plot(stage.surv, mark.time = T, main= "RFS: Tumour Stage", 
     col.main= "darkred", xlab = "Time (days)", ylab = "probability of RFS", 
     col.lab= "blue4",
     cex.lab= 0.8, lty= 2:4, col= c("deeppink", "blue", "darkgreen"))
legend(2000,1, title = "Legend", c("TI", "T2", "T3"), col=c("deeppink", 
                                                            "blue", "darkgreen"), lty=2:4,
       cex=0.5)
survdiff(Surv(mydata$RFS, mydata$RFSStatus)~TumourStage, data = mydata)

#QUESTION 3

###univariate for sex, female is our reference
sex_coxph <- coxph(Surv(mydata$RFS, mydata$RFSStatus)~factor(Sex), method = 
                     "efron")
summary(sex_coxph)
sex_ph <- cox.zph(sex_coxph, transform = "log", global = T)
sex_ph #p>0.05 not time dependant 
plot(sex_ph[1,])
abline(h=0, lty=3)

###univariate for barretts, no will be reference
BP_coxph <- coxph(Surv(mydata$RFS, 
                       mydata$RFSStatus)~factor(BarrettsPrevious), method = "efron")
summary(BP_coxph)
BP_ph <- cox.zph(BP_coxph, transform = "log", global = T)
BP_ph
plot(BP_ph[1,])
abline(h=0,lty=3)

###univariate for grade, no will be reference
grade_coxph <- coxph(Surv(mydata$RFS, mydata$RFSStatus)~factor(Grade), 
                     method = "efron")
summary(grade_coxph)
grade_ph <- cox.zph(grade_coxph, transform = "log", global = T)
grade_ph
plot(grade_ph[1,])
abline(h=-2,lty=3)

###univariate for tumor stage 
tumour_coxph <- coxph(Surv(mydata$RFS, 
                           mydata$RFSStatus)~factor(TumourStage), method = "efron")
summary(tumour_coxph)
tumour_ph <- cox.zph(tumour_coxph, transform = "log",global = T)
tumour_ph
plot(tumour_ph[1,])
abline(h=0, lty=3)
plot(tumour_ph[2,])
abline(h=2.5, lty=3)

###univariate for age 
age_coxph <- coxph(Surv(mydata$RFS, mydata$RFSStatus)~Age, method = "efron")
summary(age_coxph)
age_ph <-cox.zph(age_coxph, transform = "log", global = T)
age_ph
plot(age_ph[1,])
abline(h=0, lty=3)

####univariate for geneA 
geneA_coxph <- coxph(Surv(mydata$RFS, mydata$RFSStatus)~GeneA, method = 
                       "efron")
summary(geneA_coxph)
geneA_ph <- cox.zph(geneA_coxph, transform = "log", global = T)
geneA_ph
plot(geneA_ph[1,])
abline(h=0,lty=3)

#QUESTION 5

library(ggplot2)
mydata$TumourStage[mydata$TumourStage == 1] <- "T1"
mydata$TumourStage[mydata$TumourStage == 2] <- "T2"
mydata$TumourStage[mydata$TumourStage == 3] <- "T3"
mydata
all.coxph <- coxph(Surv(mydata$RFS, 
                        mydata$RFSStatus)~Age+BarrettsPrevious+Sex+Grade+TumourStage+GeneA,
                   method = "efron", data = mydata)
ggforest(all.coxph,data= mydata)
summary(all.coxph)

#QUESTION 4

##multivariate after removing least important variables
install.packages("MASS")
library(MASS)
stepAIC(all.coxph)
twofactor_coxph <- coxph(Surv(mydata$RFS, 
                              mydata$RFSStatus)~Grade+TumourStage, method = "efron")
ggforest(twofactor_coxph,data = mydata)
summary(twofactor_coxph)
