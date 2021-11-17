## read the data
NEI <- readRDS("summarySCC_PM25.rds")

library(dplyr)

## calculate total Emissions (in millions of tons) by year
PM25_by_year <- NEI %>% 
  group_by(year) %>% 
  summarise(total = sum(Emissions / 1000000))

## create the plot
png("plot1.png")
plot(PM25_by_year$year, PM25_by_year$total, type = "l", ylab = "PM2.5 (million tons)", xlab = "Year")
title("Total PM2.5 Emissions by Year")
dev.off()