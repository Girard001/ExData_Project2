## read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)
library(stringr)

## identify and select for coal combustion-related sources
index <- str_which(unique(SCC$EI.Sector), "Coal")
SCC_Coal <- SCC[index, ]
SCC_Coal <- select(SCC_Coal,SCC)
NEI_Coal <- inner_join(NEI, SCC_Coal, by = "SCC")  

## calculate total Emissions (in tons) by year
PM25_by_year <- NEI_Coal %>%
  group_by(year) %>% 
  summarise(total = sum(Emissions))

## create the plot
png("plot4.png")
plot(PM25_by_year$year, PM25_by_year$total, type = "l", ylab = "PM2.5 (tons)", xlab = "Year")
title("Total PM2.5 Coal Combustion-related Emissions by Year")
dev.off()