setwd("c:/enlistments/github/Project2")

NEI <- readRDS("./Data/summarySCC_PM25.rds")

# not used, left for documentation purposes.
# SCC <- readRDS("./Data/Source_Classification_Code.rds")

head(NEI)
str(NEI)

totalByYear <- aggregate(Emissions ~ year, data=NEI, sum)

png(filename="./plot1.png", width=480, height=480)

par(mar = c(4,4,2,2))
plot(
  x=totalByYear$year, 
  y=totalByYear$Emissions, 
  type="l", 
  ylab="PM2.5 emitted (total)", 
  xlab="Year",
  main="Total PM2.5 emitted by year for all sources")

dev.off()




