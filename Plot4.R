#plot 3 
#gather data

SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))



#R command to gather proper data

Baltimore_data <-NEI[NEI$fips=="24510", ]
Baltimore_emission_by_type <- NEI %>% group_by(type, year) %>% filter(fips == "24510") %>% 
  summarise(total = sum(Emissions))

#Plot the data accordingly

g<-ggplot(Baltimore_emission_by_type, aes(x = factor(year), y = total, fill = type, label = round(total)))
g <-g+  geom_col()   
g <-g+  facet_grid(. ~ type)
g <-g+   ggtitle("Total PM2.5 Emissions in Baltimore City, Maryland") + xlab("Year")+ ylab("PM2.5 Emissions in Tons")
g <-g+  theme_classic()+  theme(plot.title = element_text(hjust = 0.5))
g