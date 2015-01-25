# Read data files
NEIdata <- readRDS("data/summarySCC_PM25.rds")
NEIdata <- readRDS("data/Source_Classification_Code.rds")

#Plot6 to answer the question...
# Compare emissions from motor vehicle sources in Baltimore City with 
#emissions from motor vehicle sources in Los Angeles County, California (fips == "06037")
#Which city has seen greater changes over time in motor vehicle emissions?

normalize <- function(x) {(x-min(x)) / (max(x)-min(x))}

# Get BALTIMORE emissions from motor vehicle sources
bmore.emissions <- NEIdata[(NEIdata$fips=="24510") & (NEIdata$type=="ON-ROAD"),]
bmore.emissions.aggr <- aggregate(Emissions ~ year, data=bmore.emissions, FUN=sum)

# Get LOS ANGELES emissions from motor vehicle sources
la.emissions <- NEIdata[(NEIdata$fips=="06037") & (NEIdata$type=="ON-ROAD"),]
la.emissions.aggr <- aggregate(Emissions ~ year, data=la.emissions, FUN=sum)

bmore.emissions.aggr$County <- "Baltimore City, MD"
la.emissions.aggr$County <- "Los Angeles County, CA"
both.emissions <- rbind(bmore.emissions.aggr, la.emissions.aggr)

#USING GGPLOT2 PLOTTING SYSTEM
library(ggplot2)

png("Plot6.png")

ggplot(both.emissions, aes(x=factor(year), y=Emissions, fill=County)) +
    geom_bar(stat="identity") + 
    facet_grid(County  ~ ., scales="free") +
    ylab("Total Emissions (Tons)") + 
    xlab("Year") +
    ggtitle(expression("Motor Vehicle Emission variation\nin BALTIMORE and LOS ANGELES"))

dev.off()
