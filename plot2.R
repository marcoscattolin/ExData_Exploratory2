#read data
NEI <- readRDS("../data/summarySCC_PM25.rds")
SCC <- readRDS("../data/Source_Classification_Code.rds")

#extract data for Baltimore
BaltimoreNEI <- subset(NEI, fips == "24510")
baltimoreEmission <- tapply(BaltimoreNEI$Emissions,BaltimoreNEI$year,sum)

#plot
years <- names(baltimoreEmission)
plot(years,baltimoreEmission, type="l", lty=1, lwd=2, col="blue", ylim=c(0,max(baltimoreEmission)), ylab="Emissions (tons)", xlab = "year", main=expression("PM25 Emissions, Baltimore"))
points(years,baltimoreEmission, pch=19, col="blue")

#add regression line
years <- as.numeric(dimnames(baltimoreEmission)[[1]])
model <- lm(baltimoreEmission ~ years)
abline(model, lwd=2, col="red", lty=2)
legend("bottomleft", legend=c("PM25 Emissions (tons)","Linear regression"), lwd=c(2,2), lty=c(1,2), col=c("blue","red"))

#save plot to png
dev.copy(png,"plot2.png")
dev.off()
