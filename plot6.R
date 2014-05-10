#read data
NEI <- readRDS("../data/summarySCC_PM25.rds")
SCC <- readRDS("../data/Source_Classification_Code.rds")

#extract sources related to motor vehicles in Baltimore & LA, "Non-Road" equipment has to be discarded
vehicleSources <- SCC$SCC[(grep("^Mobile...[^Non-]",SCC$EI.Sector))]
baltLAVehicleEmissions <- subset(NEI, SCC %in% vehicleSources & (fips == "24510" | fips == "06037"))


#calculate yearly figures
aggregated <- aggregate(Emissions~year + fips ,sum,data=baltLAVehicleEmissions)
aggregated$fips <- as.factor(aggregated$fips)
levels(aggregated$fips) <- c("Los Angeles","Baltimore")

#plot
library(ggplot2)
qplot(year, Emissions, data=aggregated, facets=.~fips, main="PM25 Emissions from Motor Vehicles, Los Angeles vs. Baltimore") + geom_smooth(method="lm") + ylab("PM25 Emissions from Motor Vehicles (tons)")

#save plot to png
dev.copy(png,"plot6.png", width=800)
dev.off()

