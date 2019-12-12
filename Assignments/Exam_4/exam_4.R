library(ggplot2)
library(readr)
library(tidyverse)



dat = read.csv("./DNA_Conc_by_Extraction_Date.csv")
head(dat)

K <- dat[,-5]
B <- dat[,-4]
head(K)
head(B)

#1
hist(dat$DNA_Concentration_Katy, xlab = "Concentrations",  ylab = "Frequency", main = "Katy's Concentrations")
hist(dat$DNA_Concentration_Ben, xlab = "Concentrations", ylab = "Frequency", main = "Ben's Concentrations")

#2
Katy <- plot(x=as.factor(dat$Year_Collected), y=dat$DNA_Concentration_Katy, xlab = "YEAR", ylab = "DNA Concentratin", main= "Katy's Extractions")
Ben <- plot(x=as.factor(dat$Year_Collected), y=dat$DNA_Concentration_Ben, xlab = "YEAR", ylab = "DNA Concentration", main= "Ben's Extractions")

#3
jpeg(file= "Plot1tidz.jpeg") 
plot(x=as.factor(dat$Year_Collected), y=dat$DNA_Concentration_Katy, xlab = "YEAR", ylab = "DNA Concentratin", main= "Katy's Extractions")
dev.off()

jpeg(file= "Plot2tidz.jpeg")
plot(x=as.factor(dat$Year_Collected), y=dat$DNA_Concentration_Ben, xlab = "YEAR", ylab = "DNA Concentration", main= "Ben's Extractions")
dev.off()

#4
summary(K$DNA_Concentration_Katy)
summary(B$DNA_Concentration_Ben)

ggplot(dna_tidy, aes(Lab_Tech, DNA_Concentration))+
  geom_boxplot() +
  labs(title = "DNA Extraction Comparison",
       x = "Lab Tech",
       y= "DNA Concentration")

#Ben & Katy's Extractions by Year

df <- data.frame(Year_Collected=character(),DNA_Concentration_diff = numeric(), stringsAsFactors = F)
for(i in 1:12){
  df[i,2] <- mean(dna[dna$Year_Collected == levels(dna$Year_Collected)[i], "Ben"]) - mean(dna[dna$Year_Collected == levels(dna$Year_Collected)[i], "Katy"])
  df[i,1] <- levels(dna$Year_Collected)[i]
}

df$Year_Collected[df$DNA_Concentration_diff == min(df$DNA_Concentration_diff)]


#5

downstairs <- dat[dat$Lab == "Downstairs",]
jpeg("Ben_DNA_over_time.jpg")

ggplot(downstairs, aes(x=as.POSIXct(Date_Collected), y=DNA_Concentration_Ben))+
  geom_point() +
  labs(title= "Ben's DNA Extractions by Year", y= "DNA_Concentration_Ben", x= "Date_Collected")
dev.off()


#6

