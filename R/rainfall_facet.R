library(tidyr)

#Transform the state data into season: rainfall key-value pair for all 4 seasons for each state
ds.state.seasons <- ds.state[, "ST_UT_NM"]
ds.state.seasons$Winter = rowSums(ds.state[, c("DEC", "JAN", "FEB")])
ds.state.seasons$Summer = rowSums(ds.state[, c("MAR", "APR", "MAY")])
ds.state.seasons$Monsoon = rowSums(ds.state[, c("JUN", "JUL", "AUG")])
ds.state.seasons$Autumn = rowSums(ds.state[, c("SEP", "OCT", "NOV")])

ds.state.seasons <- ds.state.seasons %>%
  pivot_longer(cols=colnames(ds.state.seasons)[2:5], names_to = "Season", values_to="Rainfall")

india.seasons.merged <- merge(india.fortify, ds.state.seasons, by="ST_UT_NM", all.x=TRUE)
india.seasons.merged <- india.seasons.merged[order(india.seasons.merged$order),]

ggplot()+
  geom_polygon(data = india.seasons.merged[!is.na(india.seasons.merged$Season),],
               aes(x = long, y = lat, group=group, fill=Rainfall), color="black")+
  scale_fill_gradient(name="Rainfall (mm)", low = 'white', high = 'blue')+
  labs(title="Average Rainfall in States and UTs of India")+
  facet_wrap(~Season)+
  theme_linedraw()