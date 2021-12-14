#' @title Creation of a appealing textual timetable of classes
#' @name display_text_timetable
#' @description This function is used to display a table timetable.
#' @author Group 2 composed of Matteo Gross, Alessia Di Pietro, Martina Celic, Ana Gabriela Garcia, Laura Lo Priore
#' @return Visually appealing textual timetable object
#' @param i Semester to be considered (from 1 to 3)
#' @param choice Result of the function class_optim
#' @import ggplot2
#' @import scales
#' @import tidyverse
#' @export
display_text_timetable = function(i, choice) {
  
  # if(sum(as.numeric(choice$Choice))==0){
  #   stop("You have inputed impossible preferences based on the constraints.
  #        In fact, you might have selected classes that take place at the same time.
  #        Or you might have mandatory classes on certain days and not selected those days
  #        (such as QMM - Tuesday, OMM - Friday afternoon, DSBA - Wednesday
  #        afternoon for Semester 1 or Company Project - Friday morning for Semester 2).
  #        To find a suitable timetable, refresh the page and select those time slots.")}

  V1 <- V2 <- Choice <- NULL
  
  temp_1 <- readxl::read_excel(system.file(
    "extdata/Timetable_Master_Management.xlsx", 
    package = "hectimetables", mustWork = TRUE)) %>%
    mutate(Day_nice = as.factor(Day), 
           Day = recode_factor(Day_nice,
                               "Monday" = 1,
                               "Tuesday" =  2,
                               "Wednesday" = 3,
                               "Thursday" = 4,
                               "Friday" = 5)) %>%
    transmute(Day_nice, jointure = paste(Class, Day, Start, End),
              Weeks = ifelse(First_7_Weeks==1 & Last_7_Weeks==0, "First",
                      ifelse(First_7_Weeks==0 & Last_7_Weeks==1, "Last",
                      ifelse(First_7_Weeks==1 & Last_7_Weeks==1, "All", NA)))) 
  
  choice %>%
  left_join(raw_input[[i]], by = "Class") %>%
    mutate(jointure = paste(Class, Day, Start, End)) %>%
    filter(Choice == 1) %>%
    arrange(as.numeric(Day), Start) %>% 
    left_join(temp_1, by = "jointure") %>%
    mutate(Day = Day_nice, 
          BA = recode(CORE,`1` = "Yes",`0` = "No"), 
          Start = as.character(Start_nice), 
          End = as.character(End_nice)) %>%
    select(Class, Day, Start, End, Credits, BA, Weeks, Professor) 
    
}
