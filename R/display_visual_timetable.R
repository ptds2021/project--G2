#' @title Creation of a appealing visual timetable of classes
#' @name display_visual_timetable
#' @description This function is used to display a visual timetable.
#' It can be used to optimize the timetable schedule of HEC students.
#' @author Matteo Gross, Alessia Di Pietro, Martina Celic, Ana Gabriela Garcia, Laura Lo Priore
#' @return Visually appealing timetable ggplot2 object
#' @param i Semester to be considered (from 1 to 3)
#' @param choice Result of the function class_optim to be displayed
#' @import ggplot2
#' @import scales
#' @import tidyverse
#' @import ggfittext 
#' @export
display_visual_timetable = function(i, choice) {
  
  if(sum(as.numeric(choice$Choice))==0){
    stop("You have inputed impossible preferences based on the constraints.
         In fact, you might have selected classes that take place at the same time.
         Or you might have mandatory classes on certain days and not selected those days
         (such as QMM - Tuesday, OMM - Friday afternoon, DFSBA - Wednesday
         afternoon for Semester 1 or Company Project - Friday morning for Semester 2).
         To find a suitable timetable, refresh the page and select those timeslots.")}

  V1 <- V2 <- Choice <- NULL

  choice %>%
    left_join(raw_input[[i]], by = "Class") %>%
    filter(Choice == 1) %>%
    select(-V1,-V2,-Choice) %>%
    transmute(
      x1 = as.numeric(Day) - 0.5,
      x2 = as.numeric(Day) + 0.5,
      y1 = Start,
      y2 = End,
      t = CORE,
      r = Class)  %>%
  ggplot()+ 
    geom_rect(
      mapping = aes(
        xmin = x1,
        xmax = x2,
        ymin = y1,
        ymax = y2,
        fill = r),
      size = 0,
      alpha = 0.5)  +
    scale_fill_brewer(palette = "Pastel1") +
    labs(x = "", y = "Hours") +
    scale_x_discrete(limits = c("Monday", "Tuesday", "Wednesday", "Thusrday", "Friday")) +
    scale_y_continuous(breaks = seq(8, 19, by = 1), trans = scales::reverse_trans()) +
    ggfittext::geom_fit_text(aes(
                    x = x1 + (x2 - x1) / 2,
                    y = y1 + (y2 - y1) / 2,
                    label = r
                  ), reflow = TRUE,
                  padding.x = grid::unit(0, "mm"),
                  padding.y = grid::unit(-5, "mm"),) +
    theme(legend.position = "none", 
          axis.ticks = element_blank(), 
          panel.grid.major.x = element_blank(), 
          panel.grid.minor.x = element_blank(), 
          panel.grid.minor.y = element_blank())
}
