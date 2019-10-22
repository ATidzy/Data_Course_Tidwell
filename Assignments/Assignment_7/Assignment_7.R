utah = read.csv("./Utah_Religions_by_County.csv")
library(tidyverse)


buddhist <- utah %>% 
  filter(Buddhism.Mahayana >0) %>% 
  arrange(desc(Buddhism.Mahayana))

write.csv(buddhist, file = "./buddhist_counties.csv", row.names = FALSE, quote = FALSE)

utah_long = gather(utah,key = Religion, value = Proportion, -c(1:3) )

groups = kmeans(utah_long$Pop_2010,6) 
# clusters data into 6 groups based on proximity 
#to mean of potential groups
utah$Pop.Group = groups$cluster 
# assigns a new variable to utah giving group for each county

group_by(groups) %>% summarize()