#read data
NEI <- readRDS("../data/summarySCC_PM25.rds")
SCC <- readRDS("../data/Source_Classification_Code.rds")

#extract sources related to coal combustion
coalSources <- SCC$SCC[(grep("[Cc]oal",SCC$EI.Sector))]
coalEmissions <- subset(NEI, SCC %in% coalSources)

#calculate yearly figure
totCoalEmissions <- tapply(coalEmissions$Emissions,coalEmissions$year,sum)

#plot
barplot(totCoalEmissions, ylab="Emissions (tons)", 
        xlab = "year", main="PM25 Emissions from Coal Combustion, US", 
        col="grey50")

#save plot to png
dev.copy(png,"plot4.png")
dev.off()


