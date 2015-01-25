# Read data files
NEIdata <- readRDS("data/summarySCC_PM25.rds")
SCCdata <- readRDS("data/Source_Classification_Code.rds")

#Plot5 to answer the question...
#How have emissions from motor vehicle sources changed from 1999–2008 in
#Baltimore City?

#Get Baltimore emissions from motor vehicle sources
bmore.emissions <- NEIdata[(NEIdata$fips=="24510") & (NEIdata$type=="ON-ROAD"),]
bmore.emissions.aggr <- aggregate(Emissions ~ year, data=bmore.emissions, FUN=sum)

#USING GGPLOT2 PLOTTING SYSTEM
library(ggplot2)

png("Plot5.png")
ggplot(bmore.emissions.aggr, aes(x=factor(year), y=Emissions)) +
    geom_bar(stat="identity") +
    xlab("Year") +
    ylab(expression("Total PM"[2.5]*" Emissions")) +
    ggtitle("Emissions from motor vehicle sources in BALTIMORE City")

dev.off()
