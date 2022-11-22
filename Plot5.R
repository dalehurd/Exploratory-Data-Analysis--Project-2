#plot 4 
#gather data

SCCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

#Select coal combustion_related sources using keywords from the Ei.Sector column in SCCC

data_coal <- SCCC[grepl("Comb.*Coal", SCCC$EI.Sector), ]


#
coal_scc <- unique(data_coal$SCC)  # Unique SCC rows
coal_emi <- data[(NEI$SCC %in% coal_scc), ]  #cross reference to NEI data
coal_year <- coal_emi %>% group_by(year) %>% summarise(total = sum(Emissions))  #summarize years

g <- ggplot(coal_year, aes(factor(year), total/1000, label = round(total/1000))) 
g<- g + geom_col( fill = "purple")
g <- g+  ggtitle("Total coal combustion related PM2.5 Emissions") 
g <- g+  xlab("Year") + ylab("PM2.5 Emissions in Kilotons") 
g <- g+  ylim(c(0, 620)) + theme_classic()+ geom_text(size = 5, vjust = -1)
g <- g+  theme(plot.title = element_text(hjust = 0.5))
g

