#read data
NEI <- readRDS("../data/summarySCC_PM25.rds")
SCC <- readRDS("../data/Source_Classification_Code.rds")

#plot1
totalEmission <- tapply(NEI$Emissions,NEI$year,sum)
barplot(totalEmission, ylab="Emissions (tons)", 
        xlab = "year", main="PM25 Total Emissions, US", col="blue")

#save to png
dev.copy(png,"plot1.png")
dev.off()