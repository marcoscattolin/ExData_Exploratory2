#read data
NEI <- readRDS("../data/summarySCC_PM25.rds")
SCC <- readRDS("../data/Source_Classification_Code.rds")

#extract data for Baltimore and reshape by year and type
BaltimoreNEI <- subset(NEI, fips == "24510")
library(reshape2)
melted <- melt(BaltimoreNEI,id = c("year","type"), measure.vars="Emissions")
aggregated <- dcast(melted,year + type ~ variable, sum)


#plot and add regression line
library(ggplot2)
qplot(year, Emissions, data=aggregated, facets=.~type, ylab="PM25 Emissions (tons)", main="PM25 Emissions by type of source, Baltimore") + geom_smooth(method="lm")

#save plot to png
dev.copy(png,"plot3.png", width=800, height=600)
dev.off()


