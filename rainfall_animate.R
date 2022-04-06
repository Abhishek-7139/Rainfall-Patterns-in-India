library(gganimate)
library(tidyr)

#Transform the state data into month: rainfall key-value pair for all 12 months for each state
ds_state_longer <- ds_state %>%
  pivot_longer(cols=colnames(ds_state)[2:13], names_to = "MONTH", values_to="Rainfall")

india_longer_merged <- merge(india_fortify, ds_state_longer, by="ST_UT_NM", all.x=TRUE)
india_longer_merged <- india_longer_merged[order(india_longer_merged$order),]

anim <- ggplot()+
  geom_polygon(data = india_longer_merged,
               aes(x = long, y = lat, group=group, fill=Rainfall), color="black")+
  scale_fill_gradient(name="Rainfall (mm)", low = 'white', high = 'blue')+
  labs(title="Total Annual Rainfall in States and UTs of India")+
  transition_states(MONTH)

animate(anim)