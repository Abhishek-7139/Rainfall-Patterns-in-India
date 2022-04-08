ds %>%
  ggplot(mapping=aes(STATE_UT_NAME, ANNUAL))+
  geom_col()+
  labs(title="Rainfall in Indian States")+
  xlab("States/ UT")+
  ylab("Rainfall(mm)")+
  theme(axis.text.x =element_text(angle=50, vjust= 0.7, size=5))