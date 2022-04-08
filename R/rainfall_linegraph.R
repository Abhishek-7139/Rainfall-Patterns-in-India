ds.monthly <- ds.state[,colnames(ds.state)[1:13]]

ds.monthly <- 
  ds.monthly %>% 
  pivot_longer(cols=colnames(ds.monthly)[2:13],
               names_to = "Months",
               values_to="Rainfall")

monthOrder <- c("JAN","FEB","MAR","APR",
                "MAY","JUN","JUL","AUG",
                "SEP","OCT","NOV","DEC")
ds.monthly$Months <- factor(ds.monthly$Months,
                            levels = monthOrder)

regionReps <-c("ANDHRA PRADESH", "MADHYA PRADESH", "UTTARAKHAND", "WEST BENGAL", "MAHARASHTRA")

ds.monthly %>% filter(ST_UT_NM %in% regionReps) %>%
  ggplot(aes(x=Months, y=Rainfall, group=ST_UT_NM))+
  geom_line(aes(color=ST_UT_NM))+
  labs(title="Month by Month Rainfall in Regions of India\n(Approximated by states)")+
  ylab("Rainfall (mm)")+
  theme_linedraw()