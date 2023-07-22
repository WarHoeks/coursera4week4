library(tidyverse)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Of the four types of sources indicated by the typetype (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

# Filter emissions for Baltimore and group emissions by year and source type
baltimore_totals <- NEI %>% filter(fips =="24510") %>% 
  group_by(year, type) %>% 
  summarize(Emissions = sum(Emissions))

#Create PNG
png("plot3.png")

#Draw plot
baltimore_totals %>% ggplot(aes(x = year, y = Emissions, color = type)) +
  geom_line(linewidth = 2) +
  labs(title = "Yearly PM2.5 Emissions by source type in Baltimore City, Maryland",
       x ="Year",
       y = "PM2.5 Emissions in tons") +
  theme_minimal()

#Close connection
dev.off()
