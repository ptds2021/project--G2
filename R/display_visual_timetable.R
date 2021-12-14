#' @title Creation of a appealing visual timetable of classes
#' @name display_visual_timetable
#' @description This function is used to display a visual timetable using ggplot2.
#' @author Group 2 composed of Matteo Gross, Alessia Di Pietro, Martina Celic, Ana Gabriela Garcia, Laura Lo Priore
#' @return Visually appealing timetable (ggplot2 object)
#' @param i Semester to be considered
#' @param choice Result of the function class_optim
#' @param week First (1) or second (2) half of the semester
#' @import ggplot2
#' @import scales
#' @import tidyverse
#' @import ggfittext 
#' @export
display_visual_timetable = function(i, choice, week) {
  
  # if(sum(as.numeric(choice$Choice))==0){
  #   stop("You have inputed impossible preferences based on the constraints.
  #        In fact, you might have selected classes that take place at the same time.
  #        Or you might have mandatory classes on certain days and not selected those days
  #        (such as QMM - Tuesday, OMM - Friday afternoon, DFSBA - Wednesday
  #        afternoon for Semester 1 or Company Project - Friday morning for Semester 2).
  #        To find a suitable timetable, refresh the page and select those time slots.")}

  V1 <- V2 <- Choice <- NULL

  weeks <- ifelse(week == 1, "First", "Last")
  
  temp <- readxl::read_excel(system.file(
    "extdata/Timetable_Master_Management.xlsx", 
    package = "hectimetables", mustWork = TRUE)) %>%
    mutate(Day = as.factor(Day), 
           Day = recode_factor(Day,
                               "Monday" = 1,
                               "Tuesday" =  2,
                               "Wednesday" = 3,
                               "Thursday" = 4,
                               "Friday" = 5)) %>%
    transmute(jointure = paste(Class, Day, Start, End), 
              Weeks = ifelse(First_7_Weeks==1 & Last_7_Weeks==0, "First",
                             ifelse(First_7_Weeks==0 & Last_7_Weeks==1, "Last",
                                    ifelse(First_7_Weeks==1 & Last_7_Weeks==1, "All", NA)))) 
  
  choice %>%
    left_join(raw_input[[i]], by = "Class") %>%
    mutate(jointure = paste(Class, Day, Start, End)) %>%
    left_join(temp, by = "jointure") %>%
    filter(Weeks %in% c(weeks, "All")) %>%
    filter(Choice == 1) %>%
    select(-V1,-V2,-Choice) %>%
    transmute(
      x1 = as.numeric(Day) - 0.5,
      x2 = as.numeric(Day) + 0.5,
      y1 = Start,
      y2 = End,
      t = CORE,
      r = Class) %>% 
  ggplot() + 
    geom_rect(
      mapping = aes(
        xmin = x1,
        xmax = x2,
        ymin = y1,
        ymax = y2,
        fill = r),
      size = 0,
      alpha = 0.5)  +
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
