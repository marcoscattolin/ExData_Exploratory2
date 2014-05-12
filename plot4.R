#read data
NEI <- readRDS("../data/summarySCC_PM25.rds")
SCC <- readRDS("../data/Source_Classification_Code.rds")

#extract sources related to coal combustion
coalSources <- SCC$SCC[(grep("[Cc]omb.*[Cc]oal",SCC$EI.Sector))]
coalEmissions <- subset(NEI, SCC %in% coalSources)

#calculate yearly figure
totCoalEmissions <- tapply(coalEmissions$Emissions,coalEmissions$year,sum)

par(mfrow = c(2,2))

#plot
barplot(totCoalEmissions, ylab="Emissions (tons)", 
        xlab = "year", main="PM25 Emissions from \nCoal Combustion, US", 
        col="grey50")




#change 1999-2008
geography <- melt(coalEmissions, id=c("fips","year"), measure.vars="Emissions")
geography <- dcast(geography, fips ~ year,sum)

regr <- integer(0)
for (i in 1:length(geography[,1])){
        a <- lm(as.numeric(geography[i,2:5]) ~ as.numeric(colnames(geography[2:5])))
        regr[i] <- a$coefficients[2]
}

geography$coefficients9908 <- regr
geography$change9908 <- ifelse(geography$coefficients9908 == 0, 'No Change', 
                           ifelse(geography$coefficients9908 > 0, 'Increase', 'Decrease'))
barplot(table(geography$change9908), ylab="Number of counties", 
        main="Change in coal cobustion-related emissions \n1999-2008, US counties", xlab="Change based on slope of lin.regr. over (1999,2002,2005,2008)", col="blue")



#change 2005-2008
geography$coefficients0508 <- geography$`2008`-geography$`2005`
geography$change0508 <- ifelse(geography$coefficients0508 == 0, 'No Change', 
                           ifelse(geography$coefficients0508 > 0, 'Increase', 'Decrease'))
barplot(table(geography$change0508), ylab="Number of counties", 
        main="Change in emissions \n2005-2008, US counties", col="blue")




#save plot to png
dev.copy(png,"plot4.png",width=800, height=600)
dev.off()
