#plot 6 
#gather data

SCCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))


#get Vehicle Emission data (reused from previous plot)
Vehicle_records <- SCCC[grepl("Vehicle", SCCC$SCC.Level.Two), ]
Vehicle_records_unique <- unique(Vehicle_records$SCC)
Vehicle_emission <- NEI[(NEI$SCC %in% Vehicle_records_unique), ]

#Select Baltimore City and Los Angeles County data
balt <-Vehicle_emission %>% filter(fips == "24510")
LA<-Vehicle_emission %>% filter(fips == "06037")

#add Identifier and combine
balt$location <- "Baltimore City"
LA$location <- "Los Angeles County"
combined_data <- rbind(balt,LA)
  
  
  
plot_data  <-  combined_data %>%  group_by(location, year) %>% summarise(total = sum(Emissions))

#generate plot

png("Plot 6.png", width=480, height=480)

mycolors <- c("purple", "gold")

g <- ggplot(plot_data, aes(factor(year), total, fill = location, label = round(total)))
g <- g+  geom_col() + facet_grid(. ~ location) 
g <- g+ scale_fill_manual(values=mycolors)
g <- g+   ggtitle("Total Motor Vehicle Emissions") 
g <- g+  xlab("Year") + ylab("Pm2.5 Emissions in Tons") 
g <- g+  theme(plot.title = element_text(hjust = 0.5)) + ylim(c(0, 8000)) 
g <- g+   theme_classic() + geom_text(size = 4, vjust = -1)
g

dev.off()



