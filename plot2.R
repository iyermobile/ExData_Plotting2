# Read data files
NEIdata <- readRDS("data/summarySCC_PM25.rds")
SCCdata <- readRDS("data/Source_Classification_Code.rds")

#Using base plotting system, below plotshowing whether total emissions from PM2.5 decreased in 
#Baltimore City, Maryland from 1999 to 2008?

bmore.emissions <- NEIdata[NEIdata$fips=="24510",]
# group emissions by year
bmore.emissions.by.year <- aggregate(Emissions ~ year, bmore.emissions, sum)

png('Plot2.png')
barplot(height=bmore.emissions.by.year$Emissions,
        names.arg=bmore.emissions.by.year$year,
        xlab="Years", ylab=expression('Total PM'[2]*' Emission'),
        main=expression('Total PM'[2]*' Emissions in Baltimore City, '*
            'Maryland at various years'))
dev.off()
