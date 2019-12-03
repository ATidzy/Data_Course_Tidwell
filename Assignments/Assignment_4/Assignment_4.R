library(ggplot2)
library(lattice)


dat <- read.delim("./ITS_mapping.csv")
dim(dat)
str(dat)
summary(dat)

histogram(dat$Island, scales=list(x=list(rot=90)))
histogram(dat$Ecosystem, scales=list(x=list(rot=90)))


class(dat$Lat)
class(dat$Ecosystem)



png(filename = "./silly_boxplot.png")
ggplot(dat, aes(Ecosystem, Lat))+
  geom_boxplot(fill="Red")+
  labs(title = "Silly Boxplot", x= "Ecosystem", y="Latitude") +
  theme(axis.text.x = element_text(angle = 90))
  dev.off()
  
  
  
  

**Questions:**
    
    + **1. What other stuff does read.csv() do automatically?**
    ?read.csv() says "header = FALSE, sep = "", quote = "\"'",
  dec = ".", numerals = c("allow.loss", "warn.loss", "no.loss"),
  row.names, col.names, as.is = !stringsAsFactors,
  na.strings = "NA", colClasses = NA, nrows = -1,
  skip = 0, check.names = TRUE, fill = !blank.lines.skip,
  strip.white = FALSE, blank.lines.skip = TRUE,
  comment.char = "#",
  allowEscapes = FALSE, flush = FALSE,
  stringsAsFactors = default.stringsAsFactors(),
  fileEncoding = "", encoding = "unknown", text, skipNul = FALSE""
    
    + **2. How is it different from read.csv2()?**
    (sep = ",", dec = ".") vs (sep = ";", dec = ",")
    
    + **3. Why does read.csv2() even exist?**
    syntax variances
    
    + **4. How could I change the parameters of read.csv() 
           to make it so the class of the "State" column is "character" 
           instead of "factor?"**
    as.character()
             
    + **5. What command would give the summary stats for ONLY the 
           Home.Value column?**
    summary(df$Home.Value)
             
    + **6. What value is returned by the command: names(df)[4]  ?**
    name of column
             
    + **7. What is happening when you add (...col=df\$region) to 
           the above plotting code?**  
    colors by region
