library(tidyverse)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# Coal-related combustion is identified in SCC level three, which is the column I will use.

# Subset coal-related combustion emissions
coal_emissions <- SCC[str_detect(SCC$SCC.Level.Three, "[C-c]oal"),]

# Group emissions by year
coal_totals <- NEI %>% group_by(year) %>% 
  summarize(Emissions = sum(Emissions))

# Disable scientific notations
options(scipen=999)

#Create PNG
png("plot4.png")

#Draw plot
coal_totals %>% ggplot(aes(x = year, y = Emissions)) +
  geom_line(linewidth = 2) +
  labs(title = "Yearly PM2.5 Emissions from Coal-related combustion in USA",
       x ="Year",
       y = "PM2.5 Emissions in tons") +
  theme_minimal()

#Close connection
dev.off()
