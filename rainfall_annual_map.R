library(ggplot2)
library(maptools)
library(rgeos)
library(dplyr)

#Read in shape file of the state boundary map
india.shape <- 
  readShapeSpatial("./maps-master/States/Admin2.shp")

#Convert shape file to a dataframe
india.fortify <- 
  fortify(india.shape, region = "ST_NM")
#Capitalize the names of the states and UTs and also renamed column from id to ST_UT_NM
india.fortify$id = toupper(india.fortify$id)
colnames(india.fortify)[6] <- "ST_UT_NM"

#Load rainfall dataset, capitalize state names and rename column to ST_UT_NM
ds = read.csv("./dataset/district wise rainfall normal.csv")
colnames(ds)[1] <- "ST_UT_NM"
ds$ST_UT_NM = toupper(ds$ST_UT_NM)

#Create a dataset with data at only the state level by aggregating the values grouped by ST_UT_NAME
ds.state <- 
  ds %>%
  group_by(ST_UT_NM) %>%
  summarize_at(colnames(ds)[3:15], mean)

#Merge the fortified map data with the rainfall data and order it.
india.raindata <- merge(india.fortify, ds.state, by="ST_UT_NM", all.x=TRUE)
india.raindata <- india.raindata[order(india.raindata$order),]

#Plot Map of Annual Rainfall in India
ggplot()+
  geom_polygon(data = india.raindata,
               aes(x = long, y = lat, group=group, fill=ANNUAL), color="black")+
  scale_fill_gradient(name="Rainfall (mm)", low="white", high="blue")+
  labs(title="Average Annual Rainfall in States and UTs of India")+
  theme_linedraw()
