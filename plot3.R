# Read data files
NEIdata <- readRDS("data/summarySCC_PM25.rds")
SCCdata <- readRDS("data/Source_Classification_Code.rds")

#USING GGPLOT2 PLOTTING SYSTEM,  below plot answers the questions...
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008?

bmore.emissions <- NEIdata[NEIdata$fips=="24510",]

# Group data by year and Type of the source
bmore.emissions.aggr <- aggregate(Emissions ~ year + type,
                                  data=bmore.emissions,
                                  FUN=sum)

#USING GGPLOT2 PLOTTING SYSTEM
library(ggplot2)

png("Plot3.png", height=480, width=680)
ggplot(bmore.emissions.aggr, aes(x=factor(year), y=Emissions, fill=type)) +
    geom_bar(stat="identity") +
    facet_grid(. ~ type) +
    xlab("Year") +
    ylab(expression("Total PM"[2.5]*" Emission")) +
    ggtitle(expression("PM"[2.5]*paste("Emissions in BALTIMORE ",
                                       "City by various source types", sep="")))
dev.off()
