#' @title Creation of a appealing textual timetable of classes
#' @name display_text_timetable
#' @description This function is used to display a table timetable.
#' It can be used to optimize the timetable schedule of HEC students.
#' @author Matteo Gross, Alessia Di Pietro, Martina Celic, Ana Gabriela Garcia, Laura Lo Priore
#' @return Visually appealing textual timetable object
#' @param i Semester to be considered (from 1 to 3)
#' @param choice Result of the function class_optim to be displayed
#' @import ggplot2
#' @import scales
#' @import tidyverse
#' @export
display_text_timetable = function(i, choice) {
  
  if(sum(as.numeric(choice$Choice))==0){
    stop("You have inputed impossible preferences based on the constraints.
         In fact, you might have selected classes that take place at the same time.
         Or you might have mandatory classes on certain days and not selected those days
         (such as QMM - Tuesday, OMM - Friday afternoon, DFSBA - Wednesday
         afternoon for Semester 1 or Company Project - Friday morning for Semester 2).
         To find a suitable timetable, refresh the page and select those time slots.")}

  V1 <- V2 <- Choice <- NULL
  
  choice %>%
    left_join(nice_input[[i]], by = "Class") %>%
    filter(Choice == 1) %>%
    select(-V1,-V2,-Choice) 
    
}
