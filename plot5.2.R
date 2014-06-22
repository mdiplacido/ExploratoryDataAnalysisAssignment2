NEI <- readRDS("data//summarySCC_PM25.rds")
SCC <- readRDS("data//Source_Classification_Code.rds")

uniquenames <- unique(SCC$Short.Name)
indexes <- grep("Veh",uniquenames)
subsetshortnames <- uniquenames[indexes]  
subsetSCC <- SCC[SCC$Short.Name %in% subsetshortnames,]
motorscc <- unique(subsetSCC$SCC)
motorvehiclebaltimoredata <- NEI[(NEI$SCC %in% motorscc) & NEI$fips == "24510",]

aggregatedEmissionsByYear <- aggregate(motorvehiclebaltimoredata$Emissions, list(year=motorvehiclebaltimoredata$year), sum)
names(aggregatedEmissionsByYear)[2] <- "TotalEmissions"
png(filename="plot5.png",width=480,height=480,units="px")
qplot(year,TotalEmissions,data=aggregatedEmissionsByYear, geom = c("point", "smooth"), method = "lm")
dev.off()
