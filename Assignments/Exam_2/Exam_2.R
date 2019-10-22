library(tidyverse)
library(fitdistrplus)
library(modelr)
library(gridExtra)
library(scales)
library(broom)
library(lubridate)
library(caret)
library(dplyr)
library(tidyr)

sal <- read.csv("./salaries.csv")
sal_long <- pivot_longer(sal, c(AssistProf, AssocProf, FullProf), 
                         names_to = "Position", values_to = "Salary")
 
jpeg("./Tidwell_exam2_plot1.jpeg")
ggplot(sal_long,aes(Tier,Salary))+
  geom_boxplot(aes(fill=Position))+
  labs(title="Faculty Salaries - 1995")+
  scale_y_continuous(labels = scales::dollar)
dev.off()  



atmo <- read.csv("./atmosphere.csv")

mod1 = lm(Diversity ~ Aerosol_Density*Precip, data = atmo)
mod2 = lm(Diversity ~ Aerosol_Density+Precip, data = atmo)
mod3 = lm(Diversity ~ Aerosol_Density*CO2_Concentration, data = atmo)

mean_sq_err <- c((mod1a = (mean(mod1$residuals)^2)),
                 (mod2a= (mean(mod2$residuals)^2)),
                 (mod3a = (mean(mod3$residuals)^2)))
names(mean_sq_err) <- c("mod1","mod2","mod3")
bestmodel <- which(mean_sq_err == min(mean_sq_err))
bestmodel <- get(names(bestmodel))
bestmodel

atmo<-atmo %>% gather_predictions(mod1,mod2,mod3)

jpeg("./Tidwell_exam2_plot2.jpeg")
ggplot(atmo,aes(x=Precip,color=model)) +
  geom_point(aes(y=Diversity),color="Black") +
  geom_point(aes(y=pred),alpha=.2) +
  facet_wrap(~model)
dev.off()


hyp <- read.csv("./hyp_data.csv")
glimpse(hyp)

hyp = add_predictions(hyp, mod1, var = "pred1")
hyp = add_predictions(hyp, mod2, var = "pred2") 
hyp = add_predictions(hyp, mod3, var = "pred1")

#I still cn't figure out how to merge the different col lengths.
#need more time with that.

ggplot(hyp,aes(Precip,))+
  geom_point()
  geom_point(aes(y=atmo$Diversity), color="Black")+
  geom_point(aes(y=hyp$mod1preds),color="Red")


s <- summary(mod1)
s2 <- summary(mod2)
s3 <- summary(mod3)
capture.output(s, file = "model_summary1.txt")
capture.output(s2, file = "model_summary2.txt")
capture.output(s3, file = "model_summary3.txt")


#you asked for a test of the atmosphere data but I couldn't divide an
#odd number of elements by 2 so you get turrbl hyp data.  
rows = sample(nrow(hyp), replace = FALSE,nrow(hyp)/2)
modhyp = hyp[rows,]
crosshyp = hyp[-rows,]


training = caret::createDataPartition(hyp,.5)
training = (unlist(training))

train <-hyp[training,]
test <- hyp[-training,]


trainingmodel <- lm(Aerosol_Density~Precip, data = train)
trainingpreds <- add_predictions(test, trainingmodel)
testingmodel <- lm(Aerosol_Density~Precip, data = test)

testingpreds <- add_predictions(crosshyp, testingmodel,
                model = testingmodel, var = "predz")
#there is an error here that would be avoided with a better df.
#so this plot doesn't work but it would otherwise
ggplot(test,aes(Aerosol_Density,Precip)) +
  geom_point()+
  geom_smooth(method="lm", se=FALSE, alpha=.05, color="Pink") +
  geom_point(aes(y=hyp$newcol),color="Purple")



hypmod <- lm(Aerosol_Density~Precip, data =hyp)
hyp$predz <- predict(hypmod)
mean(abs(hyp$Aerosol_Density - hyp$predz))
mean(abs(test$Aerosol_Density - test$predz))
