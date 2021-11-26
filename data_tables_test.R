library(ggplot2)

HEC_test <- HEC_sem1_BA

d_new=data.frame(x1=HEC_test$Day, 
             x2=HEC_test$Day+1, 
             y1=HEC_test$Start, 
             y2=HEC_test$End, 
             t=HEC_test$CORE, 
             r=HEC_test$Class)

ggplot() +
  geom_rect(data=d_new, 
            mapping=aes(xmin=x1, xmax=x2, ymin=y1, ymax=y2, fill=r,), 
            color="black", size=0, alpha=0.5)  +
  xlim(1, 6)  +
  ylim(8.50, 19) + scale_y_reverse() +
  labs(x="Days of the week", y="Time") +
  geom_label(data=d_new, aes(x=x1+(x2-x1)/2, y=y1+(y2-y1)/2, label=r), size=2) +
  theme(legend.position="none")

