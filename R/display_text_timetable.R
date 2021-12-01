#' @title Creation of a appealing timetable of classes
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

  choice %>%
    left_join(nice_input[[i]]) %>%
    filter(Choice == 1) %>%
    select(-V1,-V2,-Choice)
}
