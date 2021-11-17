## read the data
NEI <- readRDS("summarySCC_PM25.rds")

library(dplyr)

## select for Baltimore City MD, 
## then calculate total Emissions (in tons) by year
PM25_by_year <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year) %>% 
  summarise(total = sum(Emissions))

## create the plot
png("plot2.png")
plot(PM25_by_year$year, PM25_by_year$total, type = "l", ylab = "PM2.5 (tons)", xlab = "Year")
title("Total PM2.5 Emissions by Year in Baltimore City MD")
dev.off()