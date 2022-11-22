#plot 2 
#gather data

NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))



#R command to gather proper data

Baltimore_data <-NEI[NEI$fips=="24510", ]
Baltiomore_emission_by_year <- Baltimore_data %>% group_by(year) %>% summarise(total = sum(Emissions))

#Plot the data accordingly

png("Plot 2.png", width=480, height=480)

plot_color=c("red","blue","green","orange")
plot2 <- barplot(Baltiomore_emission_by_year$total, main = "Total PM2.5 Emissions-Baltimore", 
                 xlab = "Year", ylab = "PM2.5 Emissions (tons)", 
                 names.arg = emission_by_year$year, col = plot_color,ylim = c(0,3500))

text(plot2, round(Baltiomore_emission_by_year$total), label = round(Baltiomore_emission_by_year$total), 
     pos = 3, cex = 1.2)

dev.off()