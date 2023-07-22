library(tidyverse)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

SCC_vehicles <- SCC[str_detect(SCC$Short.Name, "[V-v]ehicle"),]

# Filter emissions for Baltimore and motor vehicles and group emissions by year
baltimore_vehicles <- NEI %>% 
  filter(type =="ON-ROAD" & fips == "24510") %>% 
  filter(SCC %in% SCC_vehicles$SCC) %>% 
  group_by(year) %>% 
  summarize(Emissions = sum(Emissions))

# Disable scientific notations
options(scipen=999)

#Create PNG
png("plot5.png")

#Draw plot
baltimore_vehicles %>% ggplot(aes(x = year, y = Emissions)) +
  geom_line(linewidth = 2) +
  labs(title = "Yearly PM2.5 Emissions from motor vehicles in Baltimore City, Maryland",
       x ="Year",
       y = "PM2.5 Emissions in tons") +
  theme_minimal()

#Close connection
dev.off()
