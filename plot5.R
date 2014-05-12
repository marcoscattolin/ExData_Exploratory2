#read data
NEI <- readRDS("../data/summarySCC_PM25.rds")
SCC <- readRDS("../data/Source_Classification_Code.rds")

#extract sources related to motor vehicles in Baltimore, "Non-Road" equipment has to be discarded
vehicleSources <- SCC$SCC[(grep("^Mobile...[^Non-]",SCC$EI.Sector))]
baltimoreVehicleEmissions <- subset(NEI, SCC %in% vehicleSources & fips == "24510")

#calculate yearly figures
totBaltimoreVehicleEmissions <- tapply(baltimoreVehicleEmissions$Emissions,baltimoreVehicleEmissions$year,sum)


#plot
barplot(totBaltimoreVehicleEmissions, ylab="Emissions (tons)", 
        xlab = "year", main="PM25 Emissions from \nMotor Vehicles, Baltimore", 
        col="wheat1")


#save plot to png
dev.copy(png,"plot5.png", width= 800, height=600)
dev.off()
