library(tidyverse)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.


# Filter emissions for Baltimore and group emissions by year
baltimore_totals <- NEI %>% filter(fips =="24510") %>% 
  group_by(year) %>% 
  summarize(Emissions = sum(Emissions))

#Create PNG
png("plot2.png")

#Draw plot
plot(baltimore_totals$year, baltimore_totals$Emissions, 
     type = "b", 
     main= "Yearly total PM2.5 Emissions in Baltimore City, Maryland", 
     xlab = "Year", 
     ylab = "PM2.5 Emissions in tons")

#Close connection
dev.off()
