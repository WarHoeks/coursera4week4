library(tidyverse)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.


# Group emissions by year
yearly_totals <- NEI %>%  group_by(year) %>% 
  summarize(Emissions = sum(Emissions))

# Disable scientific notations
options(scipen=999)

#Create PNG
png("plot1.png")

#Draw plot
plot(yearly_totals$year, yearly_totals$Emissions, 
     type = "b", 
     main= "Yearly total PM2.5 Emissions in USA", 
     xlab = "Year", 
     ylab = "PM2.5 Emissions in tons")

#Close connection
dev.off()
