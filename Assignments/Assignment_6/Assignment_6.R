library(tidyverse)
library(fitdistrplus)
library(modelr)
library(gridExtra)

data("mtcars")


data2 <- subset(mtcars, am == 0)
write.csv(data2,file= "automatic_mtcars.csv")


png(filename ="./mpg_vs_hp_auto.png")
ggplot(data2, aes(x=hp,y=mpg)) +
  geom_point() + geom_smooth(method = "lm")+
  labs(title= "Horsepower and gas consumption in automatic vehicles",
       x="Horsepower", y="Miles per gallon")
dev.off()


tiff(filename ="./mpg_vs_wt_auto.tiff")
ggplot(data2, aes(x=wt,y=mpg)) +
  geom_point() + geom_smooth(method = "lm")+
  labs(title= "Weight and gas consumption in automatic vehicles",
       x="Weight", y="Miles per gallon")
dev.off()


data3 <- subset(mtcars, disp<=200)
write.csv(data3,file= "./mtcars_max200_displ.csv")

maximums <- c((which.max(mtcars$hp)),
  (which.max(data2$hp)),(which.max(data3$hp)))
names(maximums) <- c("original", "automatic","max200")

write.table(maximums, file = "hp_maximums.txt")
