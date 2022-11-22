#plot 1 
#gather data

SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))



#R command to gather proper data

emission_by_year <- NEI %>% group_by(year) %>% summarise(total = sum(Emissions))

#Plot the data accordingly
plot_color=c("red","blue","green","orange")
plot1 <- barplot(emission_by_year$total/1000, main = "Total PM2.5 Emissions", 
                 xlab = "Year", ylab = "PM2.5 Emissions (Kilotons)", 
                 names.arg = emission_by_year$year, col = plot_color, ylim = c(0,8300))

text(plot1, round(emission_by_year$total/1000), label = round(emission_by_year$total/1000), 
     pos = 3, cex = 1.2)