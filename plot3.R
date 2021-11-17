## read the data
NEI <- readRDS("summarySCC_PM25.rds")

library(dplyr)
library(ggplot2)

## select for Baltimore City MD, 
## then calculate total Emissions (in tons) by year and type
PM25_by_year <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year, type) %>% 
  summarise(total = sum(Emissions))

## create the plot
png("plot3.png")
qplot(year, total, data = PM25_by_year, color = type,
      main = "Total PM2.5 Emissions by Year and Type in Baltimore City MD", 
      ylab = "PM2.5 (tons)", xlab = "Year") + geom_line(lwd = 2)
dev.off()