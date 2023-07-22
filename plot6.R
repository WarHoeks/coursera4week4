library(tidyverse)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

SCC_vehicles <- SCC[str_detect(SCC$Short.Name, "[V-v]ehicle"),]

# Filter emissions for Baltimore and motor vehicles and group emissions by year
baltimore_vehicles <- NEI %>% 
  filter(type =="ON-ROAD" & fips == "24510") %>% 
  filter(SCC %in% SCC_vehicles$SCC) %>% 
  group_by(year) %>% 
  summarize(Emissions = sum(Emissions)) %>% 
  mutate(Name = "Baltimore City, Maryland")

# Filter emissions for LA County and motor vehicles and group emissions by year
LA_vehicles <- NEI %>% 
  filter(type =="ON-ROAD" & fips == "06037") %>% 
  filter(SCC %in% SCC_vehicles$SCC) %>% 
  group_by(year) %>% 
  summarize(Emissions = sum(Emissions)) %>% 
  mutate(Name = "LA County, California")

# Bind rows of both data frames
combined_vehicles <- bind_rows(baltimore_vehicles, LA_vehicles)

# Disable scientific notations
options(scipen=999)

#Create PNG
png("plot6.png")

#Draw plot
combined_vehicles %>% ggplot(aes(x = year, y = Emissions, color = Name)) +
  geom_line(linewidth = 2) +
  labs(title = "Yearly PM2.5 Emissions from motor vehicles in Baltimore City, Maryland compared with LA County, California",
       x ="Year",
       y = "PM2.5 Emissions in tons") +
  theme_minimal()

#Close connection
dev.off()
