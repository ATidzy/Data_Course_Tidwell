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


atmo<-atmo %>% gather_predictions(mod1,mod2,mod3)


ggplot(atmo,aes(x=Precip,color=model)) +
  geom_point(aes(y=Diversity),color="Black") +
  geom_point(aes(y=pred),alpha=.2) +
  facet_wrap(~model)

hyp <- read.csv("./hyp_data.csv")

glimpse(hyp)

hyp$mod1preds <- predict(mod1,newdata = hyp)


atmo <- read.csv("./atmosphere.csv")

merge.data.frame(atmo,hyp,)

ggplot(atmo,aes(Precip, col=model))+
  geom_point(aes(y=Diversity), color="Black")+
  geom_point(aes(y=mod1preds),color="Red")
