dat <- read.csv("./iris.csv")
library(ggplot2)



ggplot(iris, aes(x=Sepal.Length, y=Petal.Length, col=Species)) +
  geom_point() + 
  theme_minimal() +
  geom_smooth(method = "lm") +
  labs(title = "Sepal length vs petal length", subtitle = "for three iris species")
ggsave("./Assignment_5/iris_fig1.png")



ggplot(iris, aes(Petal.Width)) +
  geom_density(aes(fill=factor(Species)), alpha=0.4) + 
    labs(title = "Distribution of Petal Widths", subtitle = "for three iris species", 
       x = "Petal Width", fill="Species")+
  theme_minimal()
ggsave("./Assignment_5/iris_fig2.png")



r <- dat$Petal.Width/dat$Sepal.Width
ggplot(iris, aes(x=Species, y=r, fill = Species)) +
  geom_boxplot() + 
  theme_minimal() +
  labs(title = "Sepal- to Petal-Width Ratio", subtitle = "for three iris species", 
       x= "Species", y = "Ratio of Sepal Width to Petal Width")
ggsave("./Assignment_5/iris_fig3.png")




dat$`samples` <- rownames(dat)
dat$sep_len_z <- round((dat$Sepal.Length - mean(dat$Sepal.Length))/sd(dat$Sepal.Length), 2)
dat <- dat[order(dat$sep_len_z), ]
dat$`samples` <- factor(dat$`samples`, levels = dat$`samples`)

ggplot(iris, aes(x=dat$`samples`, y=dat$sep_len_z)) +
  geom_bar(stat='identity', aes(fill=dat$Species)) + 
  theme_minimal() +
  coord_flip() +
  labs(title = "Sepal Length deviance from the mean of all observations", 
       caption = "Note: Deviance= Sepal.Length-mean(Sepal.Length)", y="Deviance from the mean", 
       x="", fill = "Species")
ggsave("./Assignment_5/iris_fig4.png")

