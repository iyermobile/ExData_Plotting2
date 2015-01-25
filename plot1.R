# Read data files
NEIdata <- readRDS("NEI_data/summarySCC_PM25.rds")
SCCdata <- readRDS("NEI_data/Source_Classification_Code.rds")

#Using the base plotting system, below plot showing the total PM2.5 emission from all sources...
#...for each of the years 1999, 2002, 2005, and 2008

total.emissions <- aggregate(Emissions ~ year, NEIdata, sum)

png('Plot1.png')
barplot(height=total.emissions$Emissions, names.arg=total.emissions$year,
           xlab="Years", ylab=expression('Total PM'[2]*' emissions'),
           main=expression('Total PM'[2]*' Emissions from all sources'))

dev.off()
