# Read data files
NEI <- readRDS("data/summarySCC_PM25.rds")
SCCdata <- readRDS("data/Source_Classification_Code.rds")

#Plot4 to answer the question...
#Across the United States, how have emissions from coal combustion-related
#sources changed from 1999 to 2008?

# Find coal combustion-related sources
is.combustion.coal <- grepl("Fuel Comb.*Coal", SCCdata$EI.Sector)
combustion.coal.sources <- SCCdata[is.combustion.coal,]

# Find emissions from coal combustion-related sources
emissions <- NEI[(NEI$SCC %in% combustion.coal.sources$SCC), ]

# group by year
emissions.by.year <- aggregate(Emissions ~ year, data=emissions, FUN=sum)

#USING GGPLOT2 PLOTTING SYSTEM
library(ggplot2)

png("Plot4.png")

ggplot(emissions.by.year, aes(x=factor(year), y=Emissions)) +
    geom_bar(stat="identity") +
    xlab("Year") +
    ylab(expression("Total PM"[2.5]*" Emissions")) +
    ggtitle("Emissions from coal combustion-related sources")
dev.off()
