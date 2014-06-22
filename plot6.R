
setwd("c:/enlistments/github/Project2")

NEI <- readRDS("./Data/summarySCC_PM25.rds")
SCC <- readRDS("./Data/Source_Classification_Code.rds")

# seems to be some consensus in the forums that this is the grep we should be using
# initally i was just looking for "^Mobile " too broad i guess.  wasn't clear to me from the question
# that actually we are intrested in On-Road, diesel Or Gasoline
mobileSources <- SCC[grepl("Mobile.*On-Road.*(Diesel|Gasoline)",SCC$EI.Sector), ]

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

cor(x=totalByYearBaltimore$Emissions, y=totalByYearLACounty$Emissions)
