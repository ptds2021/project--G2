#' @title Creation of a appealing timetable of classes
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
#' @export
display_visual_timetable = function(i, choice) {

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
  ggplot() +
    geom_rect(
      mapping = aes(
        xmin = x1,
        xmax = x2,
        ymin = y1,
        ymax = y2,
        fill = r),
      color = "black",
      size = 0,
      alpha = 0.5)  +
    labs(x = "", y = "Hours") +
    scale_x_discrete(limits = c("Monday", "Tuesday", "Wednesday", "Thusrday", "Friday")) +
    scale_y_continuous(breaks = seq(8, 19, by = 1), trans = scales::reverse_trans()) +
    geom_label(aes(
      x = x1 + (x2 - x1) / 2,
      y = y1 + (y2 - y1) / 2,
      label = r),
      size = 2) +
    theme(legend.position = "none", 
          axis.ticks = element_blank(), 
          panel.grid.major.x = element_blank(), 
          panel.grid.minor.x = element_blank(), 
          panel.grid.minor.y = element_blank())
}
