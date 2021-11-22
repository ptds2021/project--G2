library(ggplot2)

HEC_test <- HEC_sem3_BA[c(1,3,4,9),]

d_new=data.frame(x1=HEC_sem3_BA$Day, 
             x2=HEC_sem3_BA$Day+1, 
             y1=HEC_sem3_BA$Start, 
             y2=HEC_sem3_BA$End, 
             t=HEC_sem3_BA$CORE, 
             r=HEC_sem3_BA$Class)


fig_timetable <- ggplot() +
  geom_rect(data=d_new, 
            mapping=aes(xmin=x1, xmax=x2, ymin=y1, ymax=y2, fill=r), 
            color="black", size=0, alpha=0.5) + 
  xlim(1, 6) +
  ylim(8.50, 19) +
  labs(x="Days of the week", y="Time (h)") +
  theme(legend.position="none")

