## read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)
library(stringr)

## select for Baltimore City MD & Los Angeles County CA
NEI_selected <- filter(NEI, fips == "24510" | fips == "06037")

## identify and select for motor vehicle-related sources
SCC_MVs <- SCC %>% filter(SCC.Level.One == "Mobile Sources" &
                            Data.Category  == "Onroad" ) %>%
                   select(SCC)
NEI_selected_MVs <- inner_join(NEI_selected, SCC_MVs, by = "SCC")  

## calculate total Emissions (in tons) by year by fips
PM25_by_year <- NEI_selected_MVs %>%
  group_by(year, fips) %>% 
  summarise(total = sum(Emissions))

## decode fips
PM25_by_year$fips <- str_replace(PM25_by_year$fips, "06037", "Los Angeles County")
PM25_by_year$fips <- str_replace(PM25_by_year$fips, "24510", "Baltimore City")

## create the plot
png("plot6.png")
qplot(year, total, data = PM25_by_year, color = fips,
      main = "Total PM2.5 Emissions by Year and Type in Baltimore City and LA County", 
      ylab = "PM2.5 (tons)", xlab = "Year") + geom_line(lwd = 2)
dev.off()