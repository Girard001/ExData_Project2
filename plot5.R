## read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)

## select for Baltimore City MD
NEI_Balt <- filter(NEI, fips == "24510")

## identify and select for motor vehicle-related sources
SCC_MVs <- SCC %>% filter(SCC.Level.One == "Mobile Sources" &
                       Data.Category  == "Onroad" ) %>%
                   select(SCC)
NEI_Balt_MVs <- inner_join(NEI_Balt, SCC_MVs, by = "SCC")  

## calculate total Emissions (in tons) by year
PM25_by_year <- NEI_Balt_MVs %>%
  group_by(year) %>% 
  summarise(total = sum(Emissions))

## create the plot
png("plot5.png")
plot(PM25_by_year$year, PM25_by_year$total, type = "l", ylab = "PM2.5 (tons)", xlab = "Year")
title(main = "Total PM2.5 Motor Vehicle-related Emissions by Year in Baltimore")
dev.off()