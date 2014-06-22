setwd("c:/enlistments/github/Project2")

NEI <- readRDS("./Data/summarySCC_PM25.rds")
SCC <- readRDS("./Data/Source_Classification_Code.rds")

mobileSources <- SCC[grepl("^Mobile ", SCC$EI.Sector), ]
baltimoreCity <- NEI[NEI$fips == "24510", ]

baltimoreNEIMobile <- baltimoreCity[baltimoreCity$SCC %in% mobileSources$SCC, ]

totalByYear <- aggregate(Emissions ~ year, data=baltimoreNEIMobile, sum)

png(filename="./plot5.png", width=480, height=480)

par(mar = c(4,4,2,2))
plot(
  x=totalByYear$year, 
  y=totalByYear$Emissions, 
  type="l", 
  ylab="PM2.5 emitted (total)", 
  xlab="Year",
  main="Total PM2.5 emitted by year for all Baltimore City mobile sources")

dev.off()
