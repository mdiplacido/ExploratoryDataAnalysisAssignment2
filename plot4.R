setwd("c:/enlistments/github/Project2")

NEI <- readRDS("./Data/summarySCC_PM25.rds")
SCC <- readRDS("./Data/Source_Classification_Code.rds")

head(NEI)
str(NEI)

coalSources <- SCC[grepl(" Coal\\s*$", SCC$EI.Sector), ]

NEICoal <- NEI[NEI$SCC %in% coalSources$SCC, ]

totalByYear <- aggregate(Emissions ~ year, data=NEICoal, sum)

png(filename="./plot4.png", width=480, height=480)

par(mar = c(4,4,2,2))
plot(
  x=totalByYear$year, 
  y=totalByYear$Emissions, 
  type="l", 
  ylab="PM2.5 emitted (total)", 
  xlab="Year",
  main="Total PM2.5 emitted by year for all coal sources")

dev.off()
