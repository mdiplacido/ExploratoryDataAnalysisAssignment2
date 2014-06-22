setwd("c:/enlistments/github/Project2")

NEI <- readRDS("./Data/summarySCC_PM25.rds")

# not used, left for documentation purposes.
# SCC <- readRDS("./Data/Source_Classification_Code.rds")

head(NEI)
str(NEI)

baltimoreCity <- NEI[NEI$fips == "24510", ]

totalByYear <- aggregate(Emissions ~ year, data=baltimoreCity, sum)

png(filename="./plot2.png", width=480, height=480)

par(mar = c(4,4,2,2))
plot(
  x=totalByYear$year, 
  y=totalByYear$Emissions, 
  type="l", 
  ylab="PM2.5 emitted (total)", 
  xlab="Year",
  main="Total PM2.5 emitted by year for Baltimore City")

model <- lm(totalByYear$Emissions ~ totalByYear$year)

abline(model, col="red", lwd=3)

dev.off()

summary(model)
