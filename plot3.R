library(ggplot2)

setwd("c:/enlistments/github/Project2")

NEI <- readRDS("./Data/summarySCC_PM25.rds")

# not used, left for documentation purposes.
# SCC <- readRDS("./Data/Source_Classification_Code.rds")

head(NEI)
str(NEI)

baltimoreCity <- NEI[NEI$fips == "24510", ]

totalByYearAndType <- aggregate(Emissions ~ year + type, data=baltimoreCity, sum)

png(filename="./plot3.png", width=480, height=480)

thePlot <- qplot(year, Emissions, data=totalByYearAndType, facets=type~.)
thePlot <- thePlot + geom_line() 
thePlot <- thePlot + xlab("Year")
thePlot <- thePlot + ylab("PM2.5 emitted")
thePlot <- thePlot + ggtitle("Emissions by Year and type for Baltimore City")

print(thePlot)

dev.off()