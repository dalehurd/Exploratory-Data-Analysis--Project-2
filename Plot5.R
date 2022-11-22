#plot 5 
#gather data

SCCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

#Select Vehicle emission records

Vehicle_records <- SCCC[grepl("Vehicle", SCCC$SCC.Level.Two), ]

#Calculate total emissions from motor vehicle sources in Baltimore City

Vehicle_records_unique <- unique(Vehicle_records$SCC)
Vehicle_emission <- NEI[(NEI$SCC %in% Vehicle_records_unique), ]
vehicle_aggregate <- Vehicle_emission %>% filter(fips == "24510") %>% group_by(year) %>% 
  summarise(total = sum(Emissions))

#Plot total emissions from motor vehicle sources in Baltimore City

png("Plot 5.png", width=480, height=480)

g <- ggplot(vehicle_aggregate, aes(factor(year), total, label = round(total))) 
g <- g+  geom_col( fill = "purple") 
g <- g+  ggtitle("Vehicle Emissions in Baltimore City") 
g <- g+  xlab("Year") + ylab("PM2.5 Emissions in Tons")
g <- g+  ylim(c(0, 450)) + theme_classic()+ geom_text(size = 5, vjust = -1) 
g <- g+  theme(plot.title = element_text(hjust = 0.5))+  theme_classic()
g

dev.off()