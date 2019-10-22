library(modelr) 
library(broom) 
library(dplyr) 
library(tidyr)
library(fitdistrplus)



mushy <- read.csv("./mushroom_growth.csv")
glimpse(mushy)


modlight = aov(GrowthRate ~ Light * Species, data = mushy)
summary(modlight)
plot(mushy$GrowthRate ~ mushy$Light)
abline(modlight, col="Red")

modN = lm(GrowthRate ~ Nitrogen * Species, data = mushy)
plot(mushy$GrowthRate ~ mushy$Nitrogen)
abline(modN, col="Red")
summary(modN)

modHum = aov(GrowthRate ~ Humidity*Species, data = mushy)
summary(modHum)
plot(mushy$GrowthRate ~ mushy$Humidity)
abline(modHum, col="Red")

modtemp = lm(GrowthRate ~ Temperature*Species, data = mushy)
summary(modtemp)
plot(mushy$GrowthRate ~ mushy$Temperature)
abline(modtemp, col="Red")


mean_sq_err <- c((Light = (mean(modlight$residuals)^2)),
                 (Nitrogen = (mean(modN$residuals)^2)),
                 (Humidity = (mean(modHum$residuals)^2)),
                 (Temperature = (mean(modtemp$residuals)^2)))

names(mean_sq_err) <- c("modlight","modN","modHum","modtemp")


bestmodel <- which(mean_sq_err == min(mean_sq_err))
bestmodel <- get(names(bestmodel))


preds = add_predictions(mushy, bestmodel) 
glimpse(preds)

unique(mushy$Species)
intensity = data.frame(Light = rep(c(15,25,30,35),2),
                       Species = rep(unique(mushy$Species),each=4))
predictions = predict(bestmodel, newdata = intensity)

plot(mushy$GrowthRate ~ mushy$Light,xlim=c(0,40),ylim=c(0,900))
  points(x=intensity$Light,y=predictions, col="Red")
  abline(bestmodel)
