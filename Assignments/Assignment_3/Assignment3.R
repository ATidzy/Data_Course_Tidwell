dat = read.csv("./thatch_ant.csv")



row = which(dat$Headwidth == "41mm")
col = "Headwidth"
dat[row, col] <- "41.000"

narow = which(dat$Headwidth == "")
col = "Headwidth"
dat[narow, col] <- "NA"
na.omit(dat)



class(dat$Headwidth)
as.numeric(as.character(dat$headwidth))

class(dat$Mass)
class(dat$Colony)



jpeg("./thatch_ant_by_colony.jpg")
plot(x = dat$Mass, y = dat$Headwidth, main = "Mass to Head Width Ratio of Thatch Ants", 
     xlab = "Mass", ylab = "Head Width", pch = 20, col = dat$Colony)
dev.off()



dat2 <- dat[dat$Colony<3,]
write.csv(dat2, "./col1and2.csv")
