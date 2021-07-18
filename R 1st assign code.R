getwd()
setwd("C:/Users/rraag/OneDrive/Documents")
data <- read.table("assignI2020_data.txt", header=T, sep="\t")
data
#####1#########
summary(data)

#2a
#Hypothesis testing: the mean difference of age of patients in Drug1 and 
Drug2 are the same
drug1 <- data[data$Treatment == "Drug 1",]
drug2 <- data[data$Treatment == "Drug II",]
age.drug1 <- drug1[,5]
age.drug2 <- drug2[,5]
age.drug1
age.drug2
mean(age.drug1)
mean(age.drug2)
boxplot(age.drug1, age.drug2, xlab= "Treatment", ylab= "Age", main = 
          "Boxplot: Age Vs Drug I & Drug II",col = c("violet", "pink"), col.lab= 
          "black")
axis(1, at= c(1,2), labels = c("Drug I", "Drug II"), tick = T)
shapiro.test(age.drug1)
shapiro.test(age.drug2)
t.test(age.drug1, age.drug2, var.equal = T)

#2b
sex1 <- plot(data[,3], data[,7])
sex1
#Null Ho there is no relationship between the sex and treatment they received
chisq.test(sex)
#p> 0.05 we cannot reject null Ho
fisher.test(sex)
#p>0.05 we cannot reject null Ho

#2c
stage <- plot(data[,8], data[,7])
stage
#Null Ho there is no relationship between the stage and treatment they received
chisq.test(stage)
#p>0.05 we cannot reject null Ho
fisher.test(stage)
#p>0.05 we cannot reject null Ho

#3
install.packages("survival")#for Kaplan Meier analysis
library(survival)
install.packages("survminer")#For Kaplan Meier curves using ggsurvplor()
library(survminer)

#3a
stageinsurvival <- data[, c(8,5,6)]
stageinsurvival
#creating the survival report
stage <- Surv(stage_survival[,2], stage_survival[,3])
stage
#creating survival fit
KMtest_stage <- survfit(Surv(stageinsurvival[,2], stageinsurvival[,3])~Stage, data = stageinsurvival, 
                        conf.int=0)
#plotting the survival curves
plot(KMtest_stage, mark.time = T, main= "Overall Survival: Stage I vs Stage II", 
     col.main= "darkred", xlab = "Time", ylab = "Overall survival status", col.lab= "brown4", cex.lab= 
       0.8, lty= 2:4, col= c("deeppink4", "deepskyblue4"))
legend(16,0.9, title = "Legend", c("Stage I", "Stage II"), lty = 2:4, col=c("red", "blue"), cex=0.7)
#log rank sum test for p-value
survdiff(Surv(stageinsurvival[,2], stageinsurvival[,3])~Stage, data = stageinsurvival)
#p>0.05 fail to reject

#3b
gendersurvived <- data[, c(3,5,6)]
gendersurvived
OS <- Surv(gendersurvived[,2], gendersurvived[,3])
KMtest_sex <- survfit(Surv(gendersurvived[,2], gendersurvived[,3])~Sex, data = gendersurvived, 
                      conf.int=0)
plot(KMtest_sex, mark.time = T, main= "OS: Male vs Female", 
     col.main= "darkred", xlab = "Time", ylab = "Overall survival status", col.lab= "brown4",
     cex.lab= 0.8, lty= 2:4, col= c("deeppink4", "deepskyblue4"))
legend(16,0.9, title = "Legend", c("Female", "Male"), lty = 2:4, col=c("red", "blue"),
       cex=0.7)
survdiff(Surv(gendersurvived[,2], gendersurvived[,3])~Sex, data = gendersurvived)
#p=0.01 < 0.05 reject null Ho

#3c
treatmentforsurvival <- data[, c(7,5,6)]
treatmentforsurvival
OS <- Surv(treatmentforsurvival[,2], treatmentforsurvival[,3])
OS
KMtestdrug <- survfit(Surv(treatmentforsurvival[,2], treatmentforsurvival[,3])~Treatment, data = 
                        treatmentforsurvival, conf.int=0)
plot(KMtestdrug, mark.time = T, main= "OS: Drug 1 vs Drug 2", 
     col.main= "darkred", xlab = "Time", ylab = "Overall survival status", col.lab= "brown4",
     cex.lab= 0.8, lty= 2:4, col= c("deeppink4", "deepskyblue4"))
legend(16,0.9, title = "Legend", c("Drug I", "Drug II"), lty = 2:4, col=c("red", "blue"),
       cex=0.7)
survdiff(Surv(treatmentforsurvival[,2], treatmentforsurvival[,3])~Treatment, data = 
           treatmentforsurvival) #p=0.1

#4a
response<-data[data$Response == "Responder",]
response
dim(response)
nonresponse <- data[data$Response == "Non-responder",]
nonresponse
boxplot(response[,9], nonresponse[,9], mark.time = T, main= "Responders Vs 
Nonresponders", 
        col.main= "darkred", xlab = "patients", ylab = "Protein1 level", col.lab= "brown4",
        cex.lab= 1.5, lty= 2:5, col= c("deeppink4", "deepskyblue4"))
#doing normality check
shapiro.test(response[,9])
shapiro.test(nonresponse[,9]) #p<0.05 normality failed
#doing mann whitney
#null Hypothesis: mean of protein value between nonres and res are same
wilcox.test(response[,9], nonresponse[,9])
#p<0.05 null Ho rejected

#4b
drug1 <- data[data$Treatment == "Drug 1",]
drug1
summary(drug1)
nonresdrug1 <- data[1:11, 9]
nonresdrug1
resdrug1 <- data[24:36, 9]
resdrug1
boxplot(nonresdrug1,resdrug1, main = "Drug 1: Responders Vs Nonresponders", col.main = 
          "darkred",xlab = "Patients",ylab = "Protein1 level"
        ,col.lab = "brown4",cex.lab= 1.5, col= c("deeppink4","deepskyblue4"))
shapiro.test(resdrug1) #p<0.05
shapiro.test(nonresdrug1) #p>0.05
wilcox.test(resdrug1, nonresdrug1, var.equal=F, paired = F)
#p<0.05 so reject null Ho

#4c
drug2 <- data[data$Treatment == "Drug II",]
drug2
summary(drug2)
nonresdrug2 <- data[12:23,9]
nonresdrug2
resdrug2 <- data[37:43, 9]
resdrug2
boxplot(nonresdrug2,resdrug2, main = "Drug 2: Responders Vs Nonresponders", col.main 
        = "darkred",xlab = "Patients",ylab = "Protein1 level"
        ,col.lab = "brown4",cex.lab= 1.5, col= c("deeppink4","deepskyblue4"))
shapiro.test(nonresdrug2) #p>0.05
shapiro.test(resdrug2) #p<0.05
wilcox.test(resdrug2, nonresdrug2, var.equal=F, paired = F)
#p<0.05 reject null Ho


