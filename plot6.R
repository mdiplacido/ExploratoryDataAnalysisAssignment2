
setwd("c:/enlistments/github/Project2")

NEI <- readRDS("./Data/summarySCC_PM25.rds")
SCC <- readRDS("./Data/Source_Classification_Code.rds")

mobileSources <- SCC[grepl("^Mobile ", SCC$EI.Sector), ]
baltimoreCity <- NEI[NEI$fips == "24510", ]
LACounty <- NEI[NEI$fips == "06037", ]

baltimoreNEIMobile <- baltimoreCity[baltimoreCity$SCC %in% mobileSources$SCC, ]
LACountyNEIMobile <- LACounty[LACounty$SCC %in% mobileSources$SCC, ]

totalByYearBaltimore <- aggregate(Emissions ~ year, data=baltimoreNEIMobile, sum)
totalByYearLACounty <- aggregate(Emissions ~ year, data=LACountyNEIMobile, sum)

png(filename="./plot6.png", width=480, height=480)

par(mar = c(4,4,2,2))
par(mfcol = c(2,1))

plot(
  x=totalByYearBaltimore$year, 
  y=totalByYearBaltimore$Emissions, 
  type="l", 
  ylab="PM2.5 emitted (total)", 
  xlab="Year",
  main="Total PM2.5 emitted by year for all Baltimore City mobile sources")

plot(
  x=totalByYearLACounty$year, 
  y=totalByYearLACounty$Emissions, 
  type="l", 
  ylab="PM2.5 emitted (total)", 
  xlab="Year",
  main="Total PM2.5 emitted by year for all LA County mobile sources")

dev.off()
