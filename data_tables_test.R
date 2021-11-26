library(ggplot2)

HEC_test <- HEC_sem1_BA

d_new=data.frame(x1=HEC_test$Day, 
             x2=HEC_test$Day+1, 
             y1=HEC_test$Start, 
             y2=HEC_test$End, 
             t=HEC_test$CORE, 
             r=HEC_test$Class, 
             y11=HEC_test$Start_nice)

ggplot() +
  geom_rect(data=d_new, 
            mapping=aes(xmin=x1, xmax=x2, ymin=y1, ymax=y2, fill=r,), 
            color="black", size=0, alpha=0.5)  + scale_y_reverse() +
  labs(x="Days of the week", y="Time") + 
  scale_x_discrete(limits=c("Monday", "Tuesday", "Wednesday", "Thusrday", "Friday")) +
  geom_label(data=d_new, aes(x=x1+(x2-x1)/2, y=y1+(y2-y1)/2, label=r), size=2) +
  theme(legend.position="none")




require(ggplot2)
require(scales)

#Create a test sequence of dates
test_dates = seq(from = as.POSIXct("2015-01-02 02:07:27", format="%Y-%m-%d %H:%M:%S"),
                 to = as.POSIXct("2015-01-04 02:00:00", format="%Y-%m-%d %H:%M:%S"),
                 by = "hour")
#Set seed for random variable
set.seed(1)
#Create the test data
time_data = 
    data.frame(dates = test_dates,
               measurements = runif(n = length(test_dates),
                                    min = 0, max = 1))
#Plot the data
ggplot(time_data, aes(x = dates, y = measurements)) +
    geom_line() +
    #Here is where I format the x-axis
    scale_x_datetime(labels = date_format("%Y-%m-%d %H"),
                     date_breaks = "8 hours")


require(ggplot2)
require(scales)

#Create the test data
example_data <-
    data.frame(a = as.POSIXct(c("2015-01-02 06:07:27", "2015-01-02 06:42:36", "2015-01-02 08:07:38", "2015-01-02 08:08:45", "2015-01-02 08:12:23", "2015-01-03 09:07:27", "2015-01-03 09:42:36")),
               b = c("1","1","1","1","1","1","1"))

#Pull out date and hour components
example_data$days <- as.POSIXct(format(example_data$a, "%Y-%m-%d"))
#This doesn't work because format just returns a character string, not a dateTime
example_data$hours <- format(example_data$a, "%Y-%m-%d %H")
#Instead, you need to re-cast the output of format as a dateTime
example_data$hours <- as.POSIXct(format(example_data$a, "%Y-%m-%d %H"), format="%Y-%m-%d %H")

#Plot the data
ggplot(data = example_data, aes(x=days)) + geom_bar(stat="bin")
ggplot(data = example_data, aes(x=hours)) + geom_bar(stat="bin")

#Now use axis-scaling and date_format to get just the data and hours
ggplot(data = example_data, aes(x=hours)) +
  geom_bar(stat="bin") +
  